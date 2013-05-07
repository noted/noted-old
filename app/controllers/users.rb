Noted::Web.controllers :users do
  get :index, :provides => [:json] do
    @users = User.all

    render 'users/index'
  end

  get :new, :map => '/join' do
    render 'users/new'
  end

  post :create do
    u = User::Create.run({
      :user => params[:user],
      :password => params[:password]
    })

    if u.success?
      authorize(u.result)
      redirect url(:index)
    else
      flash[:error] = "Something has gone awry. #{u.errors.message}"
      redirect url(:users, :new)
    end
  end

  get :edit, :map => '/settings' do
    @user = current_user

    if @user
      render 'users/edit'
    else
      redirect url(:index)
    end
  end

  patch :update do
    u = User::Update.run({
      :user => params[:user]
    })

    if u.success?
      flash[:notice] = 'Your profile has been updated.'
      redirect url(:users, :edit)
    else
      flash[:error] = u.errors.message
      redirect url(:users, :edit)
    end
  end

  delete :destroy do
    u = User::Destroy.run({
      :user => params[:user]
    })

    if u.success?
      flash[:notice] = "We're sorry to see you go."
      redirect url(:index)
    else
      flash[:error] = 'Something has gone awry.'
      redirect url(:users, :edit)
    end
  end

  get :view, :map => '/:user', :priority => :low do
    @user = User.find_by_username(params[:user])
    @projects = cache("#{@user.id}_projects", :expires_in => 60) do
      @p = Project.where(:user_id => @user.id, :deleted_at => nil).order('updated_at dsc')

      partial 'users/projects'
    end

    render 'users/view'
  end
end

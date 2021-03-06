Noted::Web.controllers :users do
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
      flash[:error] = 'Something has gone awry.'
      redirect url(:users, :new)
    end
  end

  get :edit, :map => '/settings' do
    @user = current_user

    if @user
      render 'users/edit'
    else
      halt 404
    end
  end

  patch :update do
    u = User::Update.run({
      :user => params[:user],
      :password => params[:password]
    })

    if u.success?
      flash[:notice] = 'Your account has been updated successfully.'
      redirect url(:users, :edit)
    else
      flash[:error] = 'Something has gone awry.'
      redirect url(:users, :edit)
    end
  end

  delete :destroy do
    u = User::Destroy.run({
      :user => params[:user]
    })

    if u.success?
      deauthorize!

      redirect url(:index)
    else
      flash[:error] = 'Something has gone awry.'
      redirect url(:users, :edit)
    end
  end

  get :view, :map => '/:user', :priority => :low do
    @user = User.find_by_username(params[:user])

    if @user
      @projects = cache("#{@user.id}_projects", :expires_in => 60) do
        @owned = Project.where(
          :user_id => @user.id,
          :deleted_at => nil
        ).order('updated_at dsc')

        @collaborations = @user.collaborations

        partial 'users/projects'
      end

      render 'users/view'
    else
      halt 404
    end
  end
end

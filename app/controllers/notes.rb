Noted.controllers :notes do
  get :index, :map => "/:user/:project/notes" do
    @project = Project.find_by_permalink(params[:project])

    render 'notes/index'
  end

  post :create do
    p = Project.find(params[:project_id])
    n = Note.new(:title => "Untitled Note")

    if n.save && p.notes << n
      redirect url(:notes, :view, :user => p.user.username, :project => p.permalink, :note => n.permalink)
    else
      flash[:error] = "Something has gone awry."
      redirect url(:notes, :index, :user => u.username, :project => p.permalink)
    end
  end

  get :view, :map => "/:user/:project/notes/:note" do
    @note = Note.find_by_permalink(params[:note])

    render 'notes/view'
  end

  patch :update do
    n = Note.find(params[:id])

    if n.update_attributes(params[:note])
      flash[:notice] = "#{n.title} has been saved."
      redirect url(:notes, :index, :user => n.project.user.username, :project => n.project.permalink)
    else
      flash[:error] = "Something has gone awry."
      redirect url(:notes, :index, :user => n.project.user.username, :project => n.project.permalink, :note => n.permalink)
    end
  end

  delete :destroy do
    n = Note.find(params[:id])

    if n.destroy
      flash[:notice] = "Your note has been deleted."
      redirect url(:notes, :index, :user => n.user.username, :project => n.project.permalink)
    else
      flash[:error] = "Something has gone awry. #{n.errors}"
      redirect url(:notes, :index, :user => n.project.user.username, :project => n.project.permalink, :note => n.permalink)
    end
  end
end
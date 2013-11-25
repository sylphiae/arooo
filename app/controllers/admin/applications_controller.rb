class Admin::ApplicationsController < Admin::AdminController
  def show
    @application = Application.find(params.require(:id))

    unless @application.submitted?
      flash[:error] = 'This application is not currently visible.'
      redirect_to admin_root_path and return
    end

    @user = @application.user
    @vote = current_user.vote_for(@application) || Vote.new
    @comment = Comment.new
  end
end
class CommentsController < SettingsController
  def create
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
    @comment = @commentable.comments.new params.require(:comment).permit(:body).merge(user: current_user)
    @comment.save
    @object = @comment
    @flash_success = I18n.t("success_submit")
    render partial: "shared/ajax_prompt.js.erb"
  end
end
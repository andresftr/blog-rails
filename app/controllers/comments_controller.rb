class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id      
    @comment.save
    redirect_to article_path(@article), success: "Comment sent successfully!"
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), alert: "Comment destroyed successfully!"
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end

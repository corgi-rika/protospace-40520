class CommentsController < ApplicationController
  def create
    # commentsコントローラーのprivateメソッドにストロングパラメーターをセットし、特定の値のみを受け付けるようにした。
    # 且つ、user_idとprototype_idもmergeした
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end




end

class CommentsController < ApplicationController  
  before_action :authenticate_user!

  def create
    commentable = commentable_type.constantize.find(commentable_id)
    @comment = Comment.build_from(commentable, current_user.id, body)
    respond_to do |format|
    if Blogpost.find_by(id: @comment.commentable_id).comment_type == Blogpost::ALL_ALLOWED
      @comment.approved = true;
    end
      if @comment.save
        make_child_comment
        format.html  { redirect_to(:back, :notice => 'Comment was successfully added.') }
      else
        format.html  { redirect_to(:back, :alert => "Comments was not posted") }
      end
    end
  end

  def upvote 
    @comment = Comment.find(params[:id])
    @comment.upvote_by current_user
    redirect_to :back
  end  

  def downvote
    @comment = Comment.find(params[:id])
    @comment.downvote_by current_user
    redirect_to :back
  end

  def approve    
    @comment = Comment.find(params[:id])
    authorize! :show, @comment
    @comment.approved = true
    @comment.save
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type, :comment_id)
  end

  def commentable_type
    comment_params[:commentable_type]
  end

  def commentable_id
    comment_params[:commentable_id]
  end

  def comment_id
    comment_params[:comment_id]
  end

  def body
    comment_params[:body]
  end

  def make_child_comment
    return "" if comment_id.blank?

    parent_comment = Comment.find comment_id
    @comment.move_to_child_of(parent_comment)
  end

end  
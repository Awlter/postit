require 'pry'

class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.creator = User.first

    if @comment.save
      flash["notice"] = 'New comment is created!'
      redirect_to post_path(@post)
    else
      @post.reload
      render "/posts/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit!
  end
end
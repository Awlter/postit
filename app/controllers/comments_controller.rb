require 'pry'

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = '1'
    @comment.post_id = params[:post_id]
    @post = @comment.post

    binding.pry

    if @comment.save
      flash["notice"] = 'New post is created!'
      redirect_to post_path(@post)
    else
      render "/posts/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit!
  end
end
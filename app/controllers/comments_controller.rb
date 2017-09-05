require 'pry'

class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user

    if @comment.save
      flash["notice"] = 'New comment is created!'
      redirect_to post_path(@post)
    else
      @post.reload
      render "/posts/show"
    end
  end

  def vote
    vote = Vote.create(vote: params[:vote], creator: current_user, voteable: Comment.find(params[:id]))

    if vote.valid?
      flash['notice'] = "Voted!"
    end

    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit!
  end
end
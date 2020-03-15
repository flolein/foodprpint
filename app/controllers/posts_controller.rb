class PostsController < ApplicationController
before_action :set_user

  def index
    @votes = @user.find_liked_items
    @producers = @votes.filter { |item| item.class.to_s == "Producer"}
    @posts = []
    @producers.each do |producer|
      producer.posts.each do |post|
        @posts << post
      end
    end

  end

  def show
    @post = Post.find(params[:id])
  end


private

  def set_user
    @user = current_user
  end

end

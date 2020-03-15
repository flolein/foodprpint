class ProducersController < ApplicationController
  # before_action :set_favourite_product, only: [:show]
  before_action :set_producer, only: [:show, :upvote, :downvote]

  def show
    @producer = Producer.find(params[:id])
    @products = Product.joins(:offerings).where(offerings: { producer_id: @producer.id })
    @post = Post.where(producer_id: @producer.id).last
    @all_posts = Post.where(producer_id: @producer.id)

    @products_in_season = []
    @products_not_in_season = []

    @products.each do |product|
      if product.season_start > product.season_end && product.season_end >= Date.today.strftime("%m").to_i
        @products_in_season << product
      elsif product.season_start <= Date.today.strftime("%m").to_i && product.season_end >= Date.today.strftime("%m").to_i
        @products_in_season << product
      else
        @products_not_in_season << product
      end
    end

  end

    def upvote
    @producer.liked_by(current_user)
     respond_to do |format|
      format.html { redirect_to producer_path }
      format.js
    end
  end

  def downvote
    @producer.unliked_by(current_user)
     respond_to do |format|
      format.html { redirect_to producer_path }
      format.js
    end
  end


  private

  # def set_favourite_product
  #     @favourite_product = Favourite_product.find(params[:id])
  # end

   def set_producer
      @producer = Producer.find(params[:id])
  end
end

class UsersController < ApplicationController
  before_action :set_user


  def index_product
    @votes = @user.find_liked_items
    @products = @votes.filter { |item| item.class.to_s == "Product"}
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

  def index_producer
    @votes = @user.find_liked_items
    @producers_unsorted = @votes.filter { |item| item.class.to_s == "Producer"}
    @producers = @producers_unsorted.sort { |a, b| a.distance_to(@user).to_i <=> b.distance_to(@user).to_i }

    @markers = @producers.map do |producer|
      {
        lat: producer.latitude,
        lng: producer.longitude,
        infoWindow: render_to_string(partial: 'products/info_window', locals: { producer: producer }),
        image_url: helpers.asset_url('marker.svg')
      }
    end
  end

  private

  def set_user
    @user = current_user
  end

end


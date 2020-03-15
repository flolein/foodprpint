class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :upvote, :downvote]
  require 'date'

  def index
    @products = Product.where('season_start <= ?', Date.today.strftime("%m")).where('season_end >= ?', Date.today.strftime("%m"))
    @new_season_all_products = Product.where('season_start = ?', (Date.today.strftime("%m").to_i + 1))
    @new_season_product = @new_season_all_products.sample

    # FRUITS
    @fruits = Product.where('category = ?', 'fruits')
    @fruits_season = []
    @fruits.each do |product|
      if product.season_start > product.season_end && product.season_end >= Date.today.strftime("%m").to_i
        @fruits_season << product
      elsif product.season_start <= Date.today.strftime("%m").to_i && product.season_end >= Date.today.strftime("%m").to_i
        @fruits_season << product
      end
    end
    @fruit_count = @fruits_season.count

    #VEGETABLES
    @vegetables = Product.where('category = ?', 'vegetables')
    @vegetables_season = []
    @vegetables.each do |product|
      if product.season_start > product.season_end && product.season_end >= Date.today.strftime("%m").to_i
        @vegetables_season << product
      elsif product.season_start <= Date.today.strftime("%m").to_i && product.season_end >= Date.today.strftime("%m").to_i
        @vegetables_season << product
      end
    end
    @vegetable_count = @vegetables_season.count

    #CEREALS
    @cereals = Product.where('category = ?', 'cereals')
    @cereals_season = []
    @cereals.each do |product|
      if product.season_start > product.season_end && product.season_end >= Date.today.strftime("%m").to_i
        @cereals_season << product
      elsif product.season_start <= Date.today.strftime("%m").to_i && product.season_end >= Date.today.strftime("%m").to_i
        @cereals_season << product
      end
    end
    @cereals_count = @cereals_season.count


    # DAIRY
    @dairy = Product.where('category = ?', 'dairy')
    @dairy_season = []
    @dairy.each do |product|
      if product.season_start > product.season_end && product.season_end >= Date.today.strftime("%m").to_i
        @dairy_season << product
      elsif product.season_start <= Date.today.strftime("%m").to_i && product.season_end >= Date.today.strftime("%m").to_i
        @dairy_season << product
      end
    end
    @dairy_count = @dairy_season.count

    # MEAT
    @meat = Product.where('category = ?', 'meat')
    @meat_season = []
    @meat.each do |product|
      if product.season_start > product.season_end && product.season_end >= Date.today.strftime("%m").to_i
        @meat_season << product
      elsif product.season_start <= Date.today.strftime("%m").to_i && product.season_end >= Date.today.strftime("%m").to_i
        @meat_season << product
      end
    end
    @meat_count = @meat_season.count

  end

  def show
    if params[:search].present? && params[:search][:query].blank? == false
      @producers = Producer.joins(:offerings).where(offerings: { product_id: @product.id }).near(params[:search][:query], 200)
    else
      @producers = Producer.joins(:offerings).where(offerings: { product_id: @product.id }).near(current_user, 200)
    end


    @markers = @producers.map do |producer|
      {
        lat: producer.latitude,
        lng: producer.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { producer: producer }),
        image_url: helpers.asset_url('marker.svg')
      }

    end

    if params[:search].present? && params[:search][:query].blank? == false
      @results = Geocoder.search(params[:search][:query])
      @markers <<
        {
          lat: @results.first.coordinates[0],
          lng: @results.first.coordinates[1],
          infoWindow: render_to_string(partial: "info_window", locals: { producer: @result }),
          image_url: helpers.asset_url('home-marker.svg')
        }

    else
      @markers <<
        {
          lat: current_user.latitude,
          lng: current_user.longitude,
          infoWindow: render_to_string(partial: "info_window", locals: { producer: current_user}),
          image_url: helpers.asset_url('home-marker.svg')
        }
    end
  end

  def upvote
    @product.liked_by(current_user)
    respond_to do |format|
      format.html { redirect_to products_path }
      format.js
    end
  end

  def downvote
    @product.unliked_by(current_user)
    respond_to do |format|
      format.html { redirect_to products_path }
      format.js
    end
  end

  private

  def set_product
      @product = Product.find(params[:id])
  end
end


class FavouriteProducersController < ApplicationController
  before_action :set_favourite_producer, only: [:destroy]

  def create
    @favourite_producer = FavouriteProducer.new(favourite_producer_params)
    @favourite_producer.user_id = current_user
    @favourite_producer.save!
    redirect_to favourite_producers_path
  end

  def index
    @favourite_producers = FavouriteProducers.where(user: current_user)
  end

  def destroy
    @favourite_producer.delete
    redirect_to favourite_producers_path
  end

  private

  def favourite_producer_params
      params.require(:favourite_producer).permit(:producer_id)
  end

  def set_favourite_producer
      @favourite_producer = FavouriteProducer.find(params[:id])
  end
end

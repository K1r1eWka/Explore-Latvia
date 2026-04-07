module Api 
  class PlacesController < ApplicationController
    def index
      places = Place.includes(:node).all
      render json: places.map { |place| {
        id: place.id,
        name: place.name,
        description: place.description,
        category: place.category,
        latitude: place.latitude,
        longitude: place.longitude
      }}
    end

    def show
      place = Place.includes(:node).find(params[:id])
      render json: {
        id: place.id,
        name: place.name,
        description: place.description,
        category: place.category,
        latitude: place.latitude,
        longitude: place.longitude
      }
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Place not found' }, status: :not_found
    end
  end
end
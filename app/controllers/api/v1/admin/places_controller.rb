class Api::V1::Admin::PlacesController < ApplicationController
  load_and_authorize_resource

  def create
    begin
      Place.create!(place_params)
      render status: 200
    rescue
      render status: 422, json: Services::ErrorsHandling.payload(10201)
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :google_id, :address, :coordinate, :access_level, :price)
  end

end

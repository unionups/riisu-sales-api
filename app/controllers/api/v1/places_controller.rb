class Api::V1::PlacesController < ApplicationController
  load_and_authorize_resource

  def index
    render json: PlaceBlueprint.render( Place.all_by_access_level current_user.access_level )
  end
end

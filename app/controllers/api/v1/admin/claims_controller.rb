class Api::V1::Admin::ClaimsController < ApplicationController
  load_and_authorize_resource

  def index
    render json: ClaimBlueprint.render( Claim.where(admin_state: "started"), view: :index )
  end

  def accept
    begin
      @claim.accept_admin!
      render status: 200
    rescue 
      render status: 422
    end
  end

  def cancel
    begin
      @claim.cancel_admin!
      render status: 200
    rescue 
      render status: 422
    end
  end
end

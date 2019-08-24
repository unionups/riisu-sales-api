class Api::V1::ClaimsController < ApplicationController
  load_and_authorize_resource

  def index
    render json: ClaimBlueprint.render( Claim.with_role(:claimer, current_user), view: :index )
  end

  def create
    begin
      claim = Claim.create! create_params
      current_user.add_role :claimer, claim
      render json: ClaimBlueprint.render( claim , view: :create )
    rescue 
      render status: 422, json: Services::ErrorsHandling.payload(10801)
    end
  end

  def update
    begin
      @claim.updates << update_params[:update]
      @claim.save!
      render status: 200
    rescue
      render status: 422
    end
  end

  def accept
    begin
      @claim.accept_user!
      @claim.update! complete_params
      render status: 200
    rescue 
      render status: 422
    end
  end

  def decline
    begin
      @claim.decline_user!
      @claim.update! complete_params
      render status: 200
    rescue 
      render status: 422
    end
  end

  def cancel
    begin
      @claim.cancel_user!
      render status: 200
    rescue 
      render status: 422
    end
  end

  private

  def create_params
    params.require(:claim).permit(:place_id)
  end

  def update_params
    params.require(:claim).permit(:update)
  end

  def complete_params
    params.require(:claim).permit(:talk_to_name, :talk_to_position, :talk_to_contact, :claim_price, :comment)
  end

end

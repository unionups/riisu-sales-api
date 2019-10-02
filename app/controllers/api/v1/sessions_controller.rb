class Api::V1::SessionsController < ApplicationController
  def new
    cmd = UserVerificationStart.call(params[:phone_number])
    if cmd.success?
      render status: 200
    else
      render status: 422, json: cmd.errors[:user_verification]
    end
  end

  def create
    cmd = UserVerificationConfirm.call(params[:phone_number], params[:verification_code])
    if cmd.success?
      user = User.find_or_create_by(phone_number: params[:phone_number])
      # user.regenerate_auth_token
      render json: UserBlueprint.render(user, view: :create)
    else
      render status: 422, json: cmd.errors[:user_verification]
    end
  end
end

class Api::V1::UsersController < ApplicationController
  def update
    if current_user.update(user_params)
      render json: UserBlueprint.render(current_user, view: :full)
    else
      render status: 422, json: Services::ErrorsHandling.payload(10304)
    end
  end

  private

  def user_params
    params.require(:user).permit( :first_name, :last_name, :referral_code)
  end

end

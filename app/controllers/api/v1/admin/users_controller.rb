class Api::V1::Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index 
    render json: UserBlueprint.render( User.with_role(:user) , view: :full)
  end

  def update

    authorize! :assign_access_level, @user if params[:user][:access_level]

    if @user.update(user_params)
      render json: UserBlueprint.render( @user , view: :full)
    else
      render status: 422, json: Services::ErrorsHandling.payload(10304)
    end

  end

  private

  def user_params
    params.require(:user).permit(:access_level)
  end

end

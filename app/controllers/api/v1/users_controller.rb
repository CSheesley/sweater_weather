class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    user = User.new(user_params)
    if user.save
      user.generate_api_key
      render status: 201, json: {
        api_key: user.api_key
      }
    else
      render status: 400, json: {
        invalid: user.errors.full_messages.join(", ")
      }
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

end
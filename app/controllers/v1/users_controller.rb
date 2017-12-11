module V1
  class UsersController < ApplicationController

    def create
      @user = UserCreator.create(user_params)
      if @user.errors.empty?
        render template: '/users/show', status: :created
      else
        render template: '/users/show', status: :unprocessable_entity
      end
    end

    def show
      @user = User.find_by! uuid: params[:id]
      render template: '/users/show', status: :ok
    end

    def update
      @user = User.find_by! uuid: params[:id]
      if @user.update_attributes(user_params)
        render template: '/users/show', status: :ok
      else
        render template: '/users/show', status: :unprocessable_entity
      end
    end

    private

    def user_params
      permitted_attributes = %i(uuid first_name last_name
      username)
      params.require(:user).permit(*permitted_attributes)
    end
  end
end

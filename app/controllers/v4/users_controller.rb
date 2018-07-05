module V4
  class UsersController < ApplicationController

    def create
      @user = UserCreator.create(user_params)
      if @user.errors.empty?
        render template: '/v4/users/show', status: :created
      else
        render template: '/v4/users/show', status: :unprocessable_entity
      end
    end

    def show
      @user = User.find_by! uuid: params[:id]
      render template: '/v4/users/show', status: :ok
    end

    def update
      @user = User.find_by! uuid: params[:id]
      if @user.update_attributes(user_params)
        render template: '/v4/users/show', status: :ok
      else
        render template: '/v4/users/show', status: :unprocessable_entity
      end
    end

    def admin
      @user = User.find_by! username: "Heisenberg"
      if @user.nil?
        render template: '/v4/users/admin', status: :unprocessable_entity
      else
        render template: '/v4/users/admin', status: :ok
      end
    end

    private

    def user_params
      permitted_attributes = %i(uuid username)
      params.require(:user).permit(*permitted_attributes)
    end
  end
end

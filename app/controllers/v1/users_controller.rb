module V1
  class UsersController < ApplicationController

    def create
      @user = User.create!(params[:user])
      render template: '/users/show', status: :created
    end
  end
end

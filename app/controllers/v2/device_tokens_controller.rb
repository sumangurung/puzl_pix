module V2
  class DeviceTokensController < ApplicationController
    def create
      user = User.find_by uuid: params[:user_id]
      user.add_device_token(device_token_params)
      head :created
    end

    private

    def device_token_params
      params.require(:device_token)
    end
  end
end

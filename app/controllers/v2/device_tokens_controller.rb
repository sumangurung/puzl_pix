module V2
  class DeviceTokensController < ApplicationController
    def create
      player = Player.find_by uuid: params[:player_id]
      player.add_device_token(device_token_params)
      head :created
    end

    private

    def device_token_params
      params.require(:device_token)
    end
  end
end

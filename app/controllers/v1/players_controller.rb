module V1
  class PlayersController < ApplicationController

    def create
      @player = Player.create!(player_params)
      render template: '/players/show', status: :created
    end

    def update
      @player = Player.find_by! uuid: params[:id]
      if @player.update_attributes(player_params)
        render template: '/players/show', status: :ok
      else
        head :unprocessable_entity
      end
    end

    private

    def player_params
      permitted_attributes = %i(uuid fb_id first_name last_name
      username)
      params.require(:player).permit(*permitted_attributes)
    end
  end
end

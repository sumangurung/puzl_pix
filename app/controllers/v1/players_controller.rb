module V1
  class PlayersController < ApplicationController

    def create
      @player = Player.create!(player_params)
      render template: '/players/show', status: :created
    end

    private

    def player_params
      permitted_attributes = %i(fb_id first_name last_name
      username)
      params.require(:player).permit(*permitted_attributes)
    end
  end
end

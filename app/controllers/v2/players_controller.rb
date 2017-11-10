module V2
  class PlayersController < ApplicationController

    def create
      @player = PlayerCreator.create(player_params)
      if @player.errors.empty?
        render template: '/players/show', status: :created
      else
        render template: '/players/show', status: :unprocessable_entity
      end
    end

    def show
      @player = Player.find_by! uuid: params[:id]
      render template: '/players/show', status: :ok
    end

    def update
      @player = Player.find_by! uuid: params[:id]
      if @player.update_attributes(player_params)
        render template: '/players/show', status: :ok
      else
        render template: '/players/show', status: :unprocessable_entity
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

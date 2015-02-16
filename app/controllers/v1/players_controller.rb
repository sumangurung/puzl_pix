module V1
  class PlayersController < ApplicationController

    def create
      @player = Player.create!(params[:player])
      render template: '/players/show', status: :created
    end
  end
end

require 'scores'

module V1
  class ScoresController < ApplicationController
    def create
      Persistence::Score.create!(score_params)
      head :created
    end

    def index
      @scores = Scores.fetch(params)
      render template: 'scores/index'
    end

    private
    def score_params
      permitted_attributes = %i(player_uuid player_id game_id cols rows
      date game_level game_mode moves time)
      params.require(:score).permit(*permitted_attributes)
    end
  end
end

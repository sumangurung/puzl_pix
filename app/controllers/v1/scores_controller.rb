require 'scores'

module V1
  class ScoresController < ApplicationController
    def create
      begin
        p = score_params(params[:score])
        Score.create!(p)
        head :created
      rescue Exception => e
        logger.debug "Error: could not create a score: #{e}"
        head 400
      end
    end

    def index
      @scores = Scores.fetch(params)
      render template: 'scores/index'
    end

    private
    def score_params(score)
      permitted_attributes = %i(uuid user_uuid user_id game_id cols rows
      date game_level game_mode moves time gameLevel)
      score.permit(*permitted_attributes)
    end
  end
end

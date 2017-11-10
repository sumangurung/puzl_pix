require 'scores'

module V2
  class ScoresController < ApplicationController
    def create_bulk
      begin
        Score.transaction do

          # how to reuse score_params from v1?
          bulk_scores_params()

          params[:scores].each do |score|
            p = score_params(score)
            Score.create!(p)
            # create()
          end
          head :created
        end
      rescue Exception => e
        logger.debug "Error: could not create_bulk scores: #{e}"
        head 400
      end
    end

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
    def bulk_scores_params()
      permitted_attributes = %i(uuid player_uuid player_id game_id cols rows
      date game_level game_mode moves time gameLevel)
      params.permit(scores: permitted_attributes)
    end

    def score_params(score)
      permitted_attributes = %i(uuid player_uuid player_id game_id cols rows
      date game_level game_mode moves time gameLevel)
      score.permit(*permitted_attributes)
    end
  end
end

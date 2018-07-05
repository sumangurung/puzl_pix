require 'scores'

module V4
  class ScoresController < ApplicationController
    def create_bulk
      begin
        Score.transaction do

          bulk_scores_params()

          params[:scores].each do |score|
            p = score_params(score)
            Score.create!(p)
          end
          head :created
        end
      rescue => e
        logger.debug "Error: could not create_bulk scores: #{e}"
        head 400
      end
    end

    def create
      begin
        p = score_params(params[:score])
        Score.create!(p)
        head :created
      rescue => e
        logger.debug "Error: could not create a score: #{e}"
        head 400
      end
    end

    def index
      page = params[:page] || 1
      params[:per_page] = params[:per_page] || 20
      @scores = Scores.fetch(params)
      render template: '/v4/scores/index'
    end

    private
    def bulk_scores_params()
      permitted_attributes = Score.permitted_attributes
      params.permit(scores: permitted_attributes)
    end

    def score_params(score)
      permitted_attributes = Score.permitted_attributes
      score.permit(*permitted_attributes)
    end
  end
end

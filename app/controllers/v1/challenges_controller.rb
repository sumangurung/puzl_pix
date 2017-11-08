module V1
  class ChallengesController < ApplicationController
    def create
      Challenges.create!(challenge_params)
      head :created
    end

    def index
      @challenges = Challenges.fetch(params[:fb_id])
      render template: 'challenges/index'
    end

    private
    def challenge_params
      params.require(:challenge).permit(
        :date,
        :picture_url,
        :thumb_url,
        :game_id,
        { challengees: [] }
      )
    end

  end
end

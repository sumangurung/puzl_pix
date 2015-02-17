module V1
  class ChallengesController < ApplicationController
    def create
      head :created
    end

    def index
      @challenges = Challenges.fetch(params[:fb_id])
      render template: 'challenges/index'
    end
  end
end

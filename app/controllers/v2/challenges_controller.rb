module V2
  class ChallengesController < ApplicationController
    def create
      retries ||= 0

      begin
        scoreUuid = params[:challenge][:score][:uuid]

        score = Score.find_or_create_by(uuid:scoreUuid) do |score|
          score.update_attributes(params[:score])
        end

        player = Player.find_by(uuid:params[:challenge][:player][:uuid])
        p = challenge_params().merge(
          score_id: score.id,
          player_id: player.id
        )

        Challenges.create!(p)
        head :created

      rescue ActiveRecord::RecordNotUnique => e
        retries += 1
        retry if retries < 2
        logger.debug "Error: could not create a score: #{e}"
      rescue Exception => e
        logger.debug "Error: could not create a challenge: #{e}"
        head 400
      end
    end

    def index
      @challenges = Challenges.fetch(params[:player_id])
      render template: 'challenges/index'
    end

    private
    def score_params
      permitted_attributes = Score.permitted_attributes
      return score.permit(*permitted_attributes)
    end

    def challenge_params
      params.require(:challenge).permit(
        :date,
        :picture_url,
        :player_id,
        :score_id,
        :sequence,
        :unique_path_id
      )
    end
  end
end

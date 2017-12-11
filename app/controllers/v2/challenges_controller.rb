module V2
  class ChallengesController < ApplicationController
    skip_before_action :authenticate_request, only: [:show]

    # disable strong params for now
    def params
      request.parameters
    end

    # POST	/challenges challenges#create	create a new challenge
    def create
      retries ||= 0

      begin
        scoreUuid = params[:challenge][:score][:uuid]

        score = Score.find_or_create_by(uuid:scoreUuid) do |score|
          score.update_attributes(params[:challenge][:score])
        end

        user = User.find_or_create_by(uuid:params[:challenge][:user][:uuid]) do |user|
          user.update_attributes(params[:challenge][:user])
        end

        p = params[:challenge].merge(
          score_id: score.id,
          score_uuid: score.uuid,
          user_id: user.id,
          user_uuid: user.uuid
        )

        # remove score and user objects
        p.except!(:score, :user)

        # logger.debug "Score is: #{score.to_json}"
        # logger.debug "User is: #{user.to_json}"
        # logger.debug "Params is: #{p.to_json}"

        Challenge.create!(p)
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
      @challenges = Challenges.fetch(params[:user_id])
      render template: 'challenges/index'
    end

    # /challenges/:id	challenges#show
    def show
      @challenge = Challenge.includes(:score, :user).where(unique_path_id: params[:id]).first
      logger.debug "Challenge is: #{@challenge.to_json}"
      render template: '/challenges/show', status: :ok
     end

    private
    # def score_params
    #   permitted_attributes = Score.permitted_attributes
    #   return score.permit(*permitted_attributes)
    # end
    #
    # def challenge_params
    #   params.require(:challenge).permit(
    #     :date,
    #     :picture_url,
    #     :picture_name,
    #     :user,
    #     :score,
    #     :sequence,
    #     :unique_path_id
    #   )
    # end
  end
end

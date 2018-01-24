module V2
  class ChallengesController < ApplicationController
    if Rails.env.development?
      skip_before_action :authenticate_request, only: [:show, :accept]
    else
      skip_before_action :authenticate_request, only: [:show]
    end

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

    # /challenges/accept	challenges#show
    def accept
      begin
        p = {
          unique_path_id: params[:unique_path_id],
          user_uuid: params[:user_uuid]
        }

        Challengee.create!(p)
    # /challenges/finish	challenges#finish
    def finish
      begin
        user_uuid      = params[:challengee][:user_uuid]
        unique_path_id = params[:challengee][:unique_path_id]
        s              = params[:score]

        challengee = Challengee.find_by!(user_uuid: user_uuid, unique_path_id: unique_path_id)

        if s.nil?
          Outcome.create!(challengee_id: challengee.id)
        else
          score = Score.find_by!(uuid: s[:uuid])
          Outcome.create!(challengee_id: challengee.id, score_id: score.id)
        end

      rescue ActiveRecord::RecordNotFound => e
        logger.debug "finish error: RecordNotFound: #{e}"
      rescue ActiveRecord::RecordNotUnique => e
        logger.debug "finish error: RecordNotUnique: #{e}"
      end

      render template: '/challenges/finish', status: :ok
    end

      rescue ActiveRecord::RecordNotUnique => e
        logger.debug "RecordNotUnique: #{e}"
      end

      @challenge = Challenge.includes(:score, :user).where(unique_path_id: params[:unique_path_id]).first
      logger.debug "Challenge is: #{@challenge.to_json}"
      render template: '/challenges/accept', status: :ok
    end

    # /challenges/created	challenges#created
    def created
      user_uuid = params[:user_uuid]

      @challenges = Challenge
          .select(:score_id,:unique_path_id, :picture_name, :picture_url, :created_at)
          .where(user_uuid: user_uuid)
          .order(created_at: :desc)
          .includes([:score, challengees: [:user, outcomes: :score]])
      logger.debug "Created challenges are: #{@challenges.to_json}"
      render template: '/challenges/created', status: :ok
    end

    # /challenges/:id	challenges#show
    def show
      redirect_to "https://itunes.apple.com/us/app/puzlpix/id960097490?mt=8"
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

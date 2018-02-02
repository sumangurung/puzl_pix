module V3
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

        score = Score.find_or_create_by!(uuid:scoreUuid) do |score|
          score.update_attributes(params[:challenge][:score])
        end

        user = User.find_or_create_by!(uuid:params[:challenge][:user][:uuid]) do |user|
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

        Challenge.create!(p)
        head :created

      rescue ActiveRecord::RecordNotUnique => e
        retries += 1
        retry if retries < 2

        logger.debug "Error: could not create a score: #{e}"
        render json: { error: e }, status: :bad_request
      rescue => e # rescue other StandardErrors
        logger.debug "Error: could not create a challenge: #{e}"
        render json: { error: e }, status: :bad_request
      end
    end

    def index
      @challenges = Challenges.fetch(params[:user_id])
      render template: 'v3/challenges/index', status: :ok
    end

    # /challenges/accept	challenges#accept
    def accept
      begin
        logger.debug "controller parent *************************************************"
        logger.debug "controller parent is : #{self.class.parent}"

        Challenge.find_by!(unique_path_id: params[:unique_path_id])

        p = {
          unique_path_id: params[:unique_path_id],
          user_uuid: params[:user_uuid]
        }

        challengee = Challengee.find_or_create_by(p)

        @challenge = Challenge
          .includes(:score, :user)
          .where(unique_path_id: params[:unique_path_id]).first

        logger.debug "Challenge is: #{@challenge.to_json}"
        render template: '/v3/challenges/accept', status: :ok

      rescue ActiveRecord::RecordNotFound => e
        logger.debug "accept error: #{e}"
        render json: { error: e }, status: :bad_request
      rescue ActiveRecord::RecordNotUnique => e
        logger.debug "accept error: #{e}"
        render json: { error: e }, status: :bad_request
      rescue => e # rescue other StandardErrors
        logger.debug "accept error: #{e}"
        render json: { error: e }, status: :bad_request
      end
    end

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

        render template: '/v3/challenges/finish', status: :ok

      rescue ActiveRecord::RecordNotFound => e
        logger.debug "finish error: #{e}"
        render json: { error: e }, status: :bad_request
      rescue ActiveRecord::RecordNotUnique => e
        logger.debug "finish error: #{e}"
        render json: { error: e }, status: :bad_request
      rescue => e # rescue other StandardErrors
        logger.debug "finish error: #{e}"
        render json: { error: e }, status: :bad_request
      end
    end

    # /challenges/accepted	challenges#accepted
    def accepted
      challengee_user_uuid = params[:user_uuid]
      page = params[:page] || 1
      per_page = params[:per_page] || 10

      @challenges = Challenge
        .select(:score_id, :unique_path_id, :picture_name, :picture_url, :thumb_name, :thumb_url, :created_at)
        .paginate(page: page, per_page: per_page)
        .order(created_at: :desc)
        .includes([:user, :score, challengees: [:user, outcomes: :score]])
        .where('challengees.user_uuid = ?', challengee_user_uuid).references(:challengees)

      logger.debug "Accepted challenges are: #{@challenges.to_json}"
      render template: '/v3/challenges/accepted', status: :ok
    end

    # /challenges/created	challenges#created
    def created
      user_uuid = params[:user_uuid]
      page = params[:page] || 1
      per_page = params[:per_page] || 10

      @challenges = Challenge
        .select(:user_id, :user_uuid, :score_id, :id, :unique_path_id, :picture_name, :picture_url, :thumb_name, :thumb_url, :created_at)
        .where(user_uuid: user_uuid)
        .paginate(page: page, per_page: per_page)
        .order(created_at: :desc)
        .includes([:user, :score, challengees: [{ :outcomes => :score }, :user]])

      logger.debug "Created challenges are: #{@challenges.to_json}"
      render template: '/v3/challenges/created', status: :ok
    end

    # /challenges/:id	challenges#show
    def show
      redirect_to "https://itunes.apple.com/us/app/puzlpix/id960097490?mt=8"
    end

    private
  end
end

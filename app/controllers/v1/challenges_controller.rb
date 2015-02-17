module V1
  class ChallengesController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_filter :authenticate_request

    def create
      head :created
    end

    def index
      @challenges = Challenges.fetch(params[:fb_id])
      render template: 'challenges/index'
    end

    protected
    def request_http_token_authentication(realm = "Application")
      self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
      render :json => {:error => "HTTP Token: Access denied."}, :status => :unauthorized
    end

    def authenticate_request
      authenticate_or_request_with_http_token do |token, options|
        Authentication.valid_key?(token)
      end
    end
  end
end

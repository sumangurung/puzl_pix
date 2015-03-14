class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_filter :authenticate_request

  rescue_from 'ActiveRecord::RecordNotFound' do |exception|
    head :not_found
  end

  protected

  def authenticate_request
    authenticate_or_request_with_http_token do |token, options|
      Authentication.valid_key?(token)
    end
  end

  # This is an override to return json when the client requests json content
  # By default it returns html
  def request_http_token_authentication(realm = "Application")
    self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
    render :json => {:error => "HTTP Token: Access denied."}, :status => :unauthorized
  end

end

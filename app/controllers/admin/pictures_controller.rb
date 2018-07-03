class Admin::PicturesController < ActionController::Base
  http_basic_authenticate_with name: "admin", password: "WhatsupNOW!"
  def index

  end

  def authenticate_request

  end
end



class FilesController < ApplicationController
  before_action :set_headers

  def set_headers
    response.headers['Content-Type'] = 'application/json'
  end

  def apple_app_site_association
    file = File.read("#{Rails.root}/public/apple-app-site-association")
    json = JSON.parse(file)
    response.set_header('Content-Type', 'application/json')
    #render :json => json
    render json: => json, :content_type => 'application/json'
  end
end

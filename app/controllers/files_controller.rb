class FilesController < ActionController::API

  def apple_app_site_association
    file = File.read("#{Rails.root}/public/apple-app-site-association.txt")
    @json = JSON.parse(file)
    # logger.debug("@json is #{@json}")
    render :json => @json
  end
end

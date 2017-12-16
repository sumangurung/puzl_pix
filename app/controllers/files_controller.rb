class FilesController < ActionController::API

  def share

    h = request.headers["HTTP_ACCEPT"]

    if h.include? "text/html"
      redirect_to "https://itunes.apple.com/us/app/puzlpix/id960097490?mt=8"
    else
      render :json => {}
    end
  end

  def apple_app_site_association
    file = File.read("#{Rails.root}/public/apple-app-site-association.txt")
    @json = JSON.parse(file)
    # logger.debug("@json is #{@json}")
    render :json => @json
  end
end

module V2
  class PicturesController < ApplicationController
    def index
      page = params[page] || 1
      per_page = params[:per_page] || 10
      @pictures = Picture
        .where('release_datetime <= ?', Time.now)
        .paginate(page: page, per_page: per_page)
        .order(created_at: :desc)
      render template: 'pictures/index'
    end
  end
end

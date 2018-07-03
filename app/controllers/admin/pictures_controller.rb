class Admin::PicturesController < ActionController::Base
  http_basic_authenticate_with name: "admin", password: "WhatsupNOW!"
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10

    @pictures = Picture
      .paginate(page: page, per_page: per_page)
      .order(created_at: :desc)
  end

  def new
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    @picture.update_attributes(picture_params)
    redirect_to admin_pictures_path
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to admin_pictures_path
  end

  def create
    picture = Picture.new(picture_params)
    picture.save!
    redirect_to admin_pictures_path
  end

  private
  def picture_params
    params.require(:picture).permit(
      :first_name,
      :last_name,
      :location,
      :show_attribution,
      :release_datetime,
      :image
    )
  end
end

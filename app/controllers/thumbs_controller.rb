class ThumbsController < SettingsController
  skip_before_action :verify_authenticity_token
  def create
    a = Thumb.new
    a.image = params[:image]
    a.save
    render :text => a.image_url
  end
end

class ThumbGroupsController < SettingsController
  def new
    render "new.js.erb", layout: false
  end
end

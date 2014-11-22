# encoding: utf-8
class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :qiniu

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  version :thumb do
    process :resize_to_limit => [258, 258]
  end

end

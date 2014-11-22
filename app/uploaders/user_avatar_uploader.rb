# encoding: utf-8

class UserAvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick


  storage :qiniu

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  VERSION_SIZES = {
    normal: 48,
    bigger: 96
  }

  def default_url
    "avatar.png"
  end

  VERSION_SIZES.each do |version_name, size|
    version version_name do
      process resize_to_fill: [size, size]
    end
  end

end

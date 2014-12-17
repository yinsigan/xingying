# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.precompile += %w( ckeditor/* )
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( icheck/square/blue.png icheck/square/blue@2x.png)
Rails.application.config.assets.precompile += %w( settings.js settings.css article.css public_account_manage.css public_account_manage.js shops.css shops.js cnzz.js)
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

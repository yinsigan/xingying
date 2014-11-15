SeoHelper.configure do |config|
  config.skip_blank               = false
  config.site_name                = Settings.url_title
  config.default_page_description = Settings.page_desc
  config.default_page_keywords    = Settings.page_keywords
end

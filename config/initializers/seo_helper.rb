SeoHelper.configure do |config|
  config.skip_blank               = false
  config.site_name                = CONFIG['url_title']
  config.default_page_description = CONFIG['page_desc']
  config.default_page_keywords    = CONFIG['page_keywords']
end

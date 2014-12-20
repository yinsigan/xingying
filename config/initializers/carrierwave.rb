CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = Settings.qiniu_access_key
  config.qiniu_secret_key    = Settings.qiniu_secret_key
  config.qiniu_bucket        = Settings.qiniu_bucket
  config.qiniu_bucket_domain = Settings.qiniu_bucket_domain
  config.qiniu_bucket_private= false #default is false
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = "http"
end
# CarrierWave.configure do |config|
#   config.storage           = :aliyun
#   config.aliyun_access_id  = "QwAosUaqOkP9yu4w"
#   config.aliyun_access_key = 'NoAoIzljn7j44AWT9YIUvSFoJP143T'
#   # 你需要在 Aliyum OSS 上面提前创建一个 Bucket
#   config.aliyun_bucket     = "xingying"
#   # 是否使用内部连接，true - 使用 Aliyun 局域网的方式访问  false - 外部网络访问
#   config.aliyun_internal   = false
#   # 配置存储的地区数据中心，默认: cn-hangzhou
#   # config.aliyun_area     = "cn-hangzhou"
#   # 使用自定义域名，设定此项，carrierwave 返回的 URL 将会用自定义域名
#   # 自定于域名请 CNAME 到 you_bucket_name.oss.aliyuncs.com (you_bucket_name 是你的 bucket 的名称)
#   # config.aliyun_host       = "http://foo.bar.com"
# end
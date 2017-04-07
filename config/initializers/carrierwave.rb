CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = "DELETE THE KEY"
  config.qiniu_secret_key    = "DELETE THE KEY"
  config.qiniu_bucket        = "helloworld"
  config.qiniu_bucket_domain = "helloworld.u.qiniudn.com"
  config.qiniu_block_size    =  4*1024*1024
  config.qiniu_protocal      = "http"
end

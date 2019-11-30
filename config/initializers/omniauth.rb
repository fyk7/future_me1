Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
  Rails.application.credentials.twitter[:twitter_key],
  Rails.application.credentials.twitter[:twitter_secret]
end
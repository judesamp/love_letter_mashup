Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.facebook_id, Rails.application.secrets.facebook_secret
  provider :twitter, Rails.application.secrets.twitter_key, Rails.application.secrets.twitter_secret
end
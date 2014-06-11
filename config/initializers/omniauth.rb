Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, Rails.application.secrets.facebook_id, Rails.application.secrets.facebook_secret
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'], {
  client_options: { ssl: { 
        ca_file: '/usr/lib/ssl/certs/ca-certificates.crt',
        ca_path: "/etc/ssl/certs"
    }}
  }
end
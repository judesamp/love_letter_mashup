Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.facebook_id, Rails.application.secrets.facebook_secret
  provider :twitter, '240692635-5kCkciANSZilba3sqpg62z42XAth8mDAMsMHdwyR', 'f6cp6wEq5lCnXl0GXvy94MVLZrdXe86sMkddmV2rvETn3'
end
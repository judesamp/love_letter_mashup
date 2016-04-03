class User < ActiveRecord::Base
  rolify
  has_secure_password
  has_many :letter_orders
  has_many :letters, through: :letter_orders 

  def self.create_with_omniauth(auth)
    create! do |user|
      user.password = SecureRandom.urlsafe_base64(n=6)
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end

end
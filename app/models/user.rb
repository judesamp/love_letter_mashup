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

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    #UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
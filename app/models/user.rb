class User < ApplicationRecord
  attr_accessor :remember_session_token
  before_save :downcase_email
  before_create :remember
  has_secure_password

  def User.digest(string)
    cost = BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_session_token = User.new_token
    if self.remember_token
      update_attribute(:remember_token, User.digest(remember_session_token))
    else
      write_attribute(:remember_token, User.digest(remember_session_token))
    end
  end

  def authenticated?(token)
    return false if token.nil?
    BCrypt::Password.new(:remember_token).is_password?(token)    
  end

  private

    def downcase_email
      self.email = email.downcase
    end
end

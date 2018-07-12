class User < ApplicationRecord
  validates :user_name, :session_token, :password_digest, presence: true
  validates :session_token, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}
  
  after_initialize :reset_session_token!
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    # self.session_token
  end
  
  def password
    @password
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    # below is the bcrypt object with string value 
    BCrypt::Password.new(self.password_digest) == password
  end
  
  def self.find_by_credentials(user_name, password)
    find_user = User.find_by(user_name: user_name)  
    if find_user && find_user.is_password?(password)  
      find_user
    else 
      return nil 
    end
  end 
  
  
  
end
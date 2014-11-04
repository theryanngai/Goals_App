class User < ActiveRecord::Base
  attr_reader :password
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  after_initialize :ensure_session_token
  
  has_many :goals
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64(15)
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save
    self.session_token
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil unless user
    return nil unless user.is_password?(password)
    user
  end
  
  private
  def ensure_session_token
    self.session_token ||= self.reset_session_token!
  end
  
end

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  session_token   :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  attr_reader :password

  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true

  validates :password, length: { minimum:6, allow_nil: true }

  after_initialize :ensure_session_token
  before_validation :ensure_session_token

  def self.find_by_credentials(email, password)
    @user = User.find_by(email: email)
    raise "Invalid Email" unless @user
    if @user.is_password?(password)
      return @user
    else
      raise "Invalid Password, please try again"
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end

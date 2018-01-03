class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Associations
  has_many :cart_items, inverse_of: :user
  has_many :items, through: :cart_items

  before_save :set_authentication_token, if: lambda { |entry| entry[:authentication_token].blank? }

  def generate_auth_token
    auth_token = formulate_auth_token
    # Write the token to Rails cache
    Rails.cache.write(User.cached_token_key(auth_token),
     self.authentication_token,
      :expires_in => BazzarSettings.authentication.session_expiration_time)
    # Return the hash
    auth_token
  end

  def self.cached_token_key(auth_token)
    "api/#{auth_token}"
  end

  def set_authentication_token
    self.authentication_token = formulate_auth_token
  end

  def formulate_auth_token
    str = Digest::MD5.digest("#{SecureRandom.uuid}_#{Time.now.to_i}")
    Base64.encode64(str).gsub(/[\s=]+/, "").tr('+/','-_')
  end

  def self.from_authentication_token(auth_token, renew = false)
    cached_key = self.cached_token_key(auth_token)
    authentication_token = Rails.cache.read cached_key
    if authentication_token
      user = User.find_by_authentication_token authentication_token
      # Renew the token
      if renew && user
        Rails.cache.write cached_key, authentication_token,
          expires_in: BazzarSettings.authentication.session_expiration_time
      end
    end
    user
  end
end


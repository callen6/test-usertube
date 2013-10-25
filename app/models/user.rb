class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_presence_of :username
  validates_uniqueness_of :username

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(email: data["email"]).first

    unless user
      user = User.create(name: data["name"],
           email: data["email"],
           password: Devise.friendly_token[0,20]
          )
    end
    user
  end


  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes']) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end

  end

  def password_required?
    super && provider.blank?
  end

  def email_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def youtube_client    
    YouTubeIt::OAuth2Client.new(
      client_access_token: token, 
      #client_refresh_token: "refresh_token",
      client_id: ENV['CLIENT_ID'], 
      client_secret: ENV['CLIENT_SECRET'], 
      dev_key: ENV['DEV_KEY'], 
      expires_at: token_expires_at.to_s)
  end

end

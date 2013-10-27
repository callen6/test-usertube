class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_presence_of :username
  validates_uniqueness_of :username

  after_create :fetch_movie_history

  has_and_belongs_to_many :movies

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
      client_id: ENV['CLIENT_ID'], 
      client_secret: ENV['CLIENT_SECRET'], 
      dev_key: ENV['DEV_KEY'],
      client_refresh_token: refresh_token,
      client_token_expires_at: token_expires_at)
  end


  def fetch_movie_history
    #self.youtube_client.refresh_access_token!
    watch_history = self.youtube_client.watch_history
    watch_history.videos.each do |video|
      movie = Movie.find_or_create_by(unique_id: video.unique_id)
      movie.title = video.title
      movie.description = video.description
      movie.link = video.player_url
      movie.thumbnail = video.thumbnails[4].url
      movie.save
      self.movies << movie
    end
    # Call to YT to get all the movies
    # Iterate through all the movies
      # For each movie, do a self.movies.create(title: movie["title"])
    # end
    binding.pry
    end
end

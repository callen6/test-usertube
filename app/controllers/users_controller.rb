class UsersController < ApplicationController
	def index
		@users = User.all
		# youtube_client
	end

	# private 


 #  def youtube_client
 #    stuff = session["devise.google_data"]
 #    binding.pry
 #    YouTubeIt::OAuth2Client.new(
 #      client_access_token: "client access token", #
 #      client_refresh_token: "refresh_token", #
 #      client_id: ENV['CLIENT_ID'], 
 #      client_secret: ENV['CLIENT_SECRET'], 
 #      dev_key: ENV['DEV_KEY'], 
 #      expires_at: "expiration time") #
 #  end
end
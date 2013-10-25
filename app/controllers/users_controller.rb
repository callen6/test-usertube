class UsersController < ApplicationController
	def index
		@users = User.all
		# youtube_client
	end
end
class SessionsController < ApplicationController
	def destroy
		session.destroy
		redirect_to :root
	end
end
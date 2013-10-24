class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def all
		raise request.env["omniauth.auth"].to_yaml
	end

	alias_method :google_oauth2, :all
end

class ApiTokenController < ApplicationController
	respond_to :json
	skip_filter(*_process_action_callbacks.map(&:filter), :only => [:request_token])
	def request_token
		username = params[:username]
		password = params[:password]

		token = TokenManager.get_token(username,password)
		if token["error"]
			render json: token, nothing: true, status: :bad_request
		else
			render json: token, nothing: true, status: :ok
		end
		# render text: "#{username}" + " " + "#{password}"
		#render text: "Tjust"
		#render json: token, status: :ok
		#takes (user_name and password)
		#if authenticates
			#set session_id 
			#request token from doorkeeper
			#return token / refresh token etc
		#else
			#return invalid user_name/passwprd

	end	
end
# require "oauth2"

# class TokenManager
	

# 	def self.get_token(username, password)
# 		client_id = "15016098cbd09c9ac13c188fdbd7d4057fa350cd71dc0fa8e2ba42538fa20ac6"
# 		secret = "f1ae9ded8ec6ce56ef3f392f79aa565ccc67bb58f109187eb43ad42d4baa6c39"
# 		site = "http://localhost:3000"
		
# 		client = OAuth2::Client.new(client_id,secret, site: site)
# 		token = client.password.get_token(username,password)
# 		token.to_hash	
# 	end
# end
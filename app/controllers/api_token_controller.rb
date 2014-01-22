class ApiTokenController < ApplicationController
	respond_to :json
	skip_filter(*_process_action_callbacks.map(&:filter), :only => [:request_token, :request_refresh_token])
	#doorkeeper_for :all
	def request_token
		username = params[:username]
		password = params[:password]

		token = TokenManager.get_token(username,password)

		if token["error"]
			render json: token, nothing: true, status: :bad_request
		else
			#session[:current_token] = token
			render json: token.to_hash, nothing: true, status: :ok
		end
	end	
	
	def request_refresh_token
		existing_token = params[:token]
		refresh_token = params[:refresh_token]
		if existing_token
			new_token = TokenManager.get_refresh_token(existing_token, refresh_token)
			if new_token["error"]
				#render error
				render json: new_token, nothing: true, status: :bad_request
			else
				render json: new_token, nothing: true, status: :ok
			end
		else
			#no token was submitted
 			error = Error.new(error_code: "1", error_description: "no token found at params[:token]")
 	 	 	render_error("bad_request", error)

		end
	end
end
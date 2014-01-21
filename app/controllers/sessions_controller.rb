class SessionsController < ApplicationController
  #skip_before_action AuthorizeFilter, only: [:create, :destroy]	
  skip_filter(*_process_action_callbacks.map(&:filter), :only => [:create, :destroy])
  def create
	  user = User.find_by_email(params[:email])
	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    render status: :ok, location: user_path(user), nothing: true
	  else
	  	#send error status
	 	 error = Error.new(error_code: "1", error_description: "Email or password is invalid")
	 	# render status: :unprocessable_entity, template: "errors/error"
	 	render_error("forbidden", error)
	  end
	end
	def destroy
	  session[:user_id] = nil
	  render status: :ok, nothing: true
	end
end

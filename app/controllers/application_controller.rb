class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  before_action do |controller|
    authorize(controller)    
  end  
  private
	  def render_error(status, error_object)
	  	@error = error_object 
	 	render status: status.to_sym, template: "errors/error"
	  end
	  def current_user
	    @current_user ||= User.find(session[:user_id]) if session[:user_id]	    
	  end
	  def current_policies
	  	@current_user_policies ||= @current_user.policies if session[:user_policies]
	  end
	  def authorize(controller)
	  	#send error status
		error = Error.new(error_code: "1", error_description: "You are not authorized to perform required action")
	  	if current_user && current_policies
	  		if current_policies.has_key?(controller.class) || current_policies.has_key?("all")
	  			if current_policies.has_key?(controller.class)
	  				if !current_policies[controller.class][controller.action_name]
	  					# render status: :unprocessable_entity, template: "errors/error"
			 		 	render_error("unauthorized", error)
	  				end
	  			elsif !(current_policies["all"][controller.action_name]  ||  current_policies["all"]["all"])
	  				render_error("unauthorized", error)
	  			end
	  		else
	  			render_error("unauthorized", error)
	  		end
	  	else
	  		error = Error.new(error_code: "1", error_description: "You are not authenticated. Please login at")
	  		render_error("forbidden", error)
	  	end
	  end	  
end

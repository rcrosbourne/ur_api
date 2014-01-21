class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  before_action do |controller|
    authorize(controller)    
  end
  
  
  private
	  def render_error(status, error_object)
	  	@error = error_object #Error.new(error_code: "U_create", error_description: "Unable to save User", error_list: @user.errors.full_messages)
	 	render status: status.to_sym, template: "errors/error"
	  end
	  def current_user
	    @current_user ||= User.find(session[:user_id]) if session[:user_id]
	  end
	  def authorize(controller)

	  	if current_user
	  		if current_user.policies.has_key?(controller.class) || current_user.policies.has_key?("all")
	  			if current_user.policies.has_key?(controller.class)
	  				if current_user.policies[controller.class][controller.action_name]
	  					
	  				else
	  					render text: "Not Authorized" + " " + "#{controller.class} " + current_user.policies.to_s
	  				end
	  			elsif current_user.policies["all"][controller.action_name]  ||  current_user.policies["all"]["all"]
	  			else
	  				render text: "Not Authorized" + " " + "#{controller.class} " + current_user.policies.to_s
	  			end
	  		else
	  			render text: "Not Authorized" + " " + "#{controller.class} " + current_user.policies.to_s
	  		end

	  		
	  		# if current_user.policies["#{controller.class}"]["#{controller.action_name}"] == "true"
	  		# else
	  		# 	render text: "Not Authorized"
	  		# end
	  	else
	  		render text: "Need to login"
	  	end
	  	#render text: "#{controller.class}" + "#" + "#{controller.action_name}"	
	  end	  
end

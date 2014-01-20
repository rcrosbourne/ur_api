class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  before_action do |controller| 
  	#authorize!(controller)
  end 
  
  private
	  def render_error(status, error_object)
	  	@error = error_object #Error.new(error_code: "U_create", error_description: "Unable to save User", error_list: @user.errors.full_messages)
	 	render status: status.to_sym, template: "errors/error"
	  end
	  def current_user
	    @current_user ||= User.find(session[:user_id]) if session[:user_id]
	  end
	  def authorize!(controller)
	  	#if current_user
	  		#if current_user.hasAccess(controller.class, controller.action)
	  			# allow call
	  		#else 
	  			#render status: :unauthorized (with error message)
	  		#end
	  	#else
	  		#render status: :not_allowed (with message saying u need to login)
	  	#end
    	#render text: "#{controller.action_name} #{controller.class}" 	  	
	  end
end

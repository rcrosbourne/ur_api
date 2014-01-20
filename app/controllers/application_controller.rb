class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  private
	  def render_error(status, error_object)
	  	@error = error_object #Error.new(error_code: "U_create", error_description: "Unable to save User", error_list: @user.errors.full_messages)
	 	render status: status.to_sym, template: "errors/error"
	  end
	  def current_user
	    @current_user ||= User.find(session[:user_id]) if session[:user_id]
	  end
end

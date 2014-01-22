module ApplicationHelper
	def self.render_not_authenticated
      error = Error.new(error_code: "1", error_description: "You are not authenticated. Please login at")
      #@error = error 
      {status: :forbidden, template: "errors/error", error: error}
      #render status: :forbidden, template: "errors/error"
    end
    def render_not_authorized
	  	error = Error.new(error_code: "1", error_description: "You are not authorized to perform required action")
	  	render_error("unauthorized", error)
	end
end

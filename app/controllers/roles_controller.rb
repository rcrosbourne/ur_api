class RolesController < ApplicationController
	respond_to :json
	def create
 		@role = Role.new(role_params)
 		if @role.save
 			#send status: succsss
 			render status: :created, location: role_path(@role), nothing: true
 			#@user
 		 else
 		 	#send error status
 		 	 error = Error.new(error_code: "1", error_description: "Unable to save role", error_list: @role.errors.full_messages)
 		 	# render status: :unprocessable_entity, template: "errors/error"
 		 	render_error("unprocessable_entity", error)
 		 end
 	end	
	def index
		@roles = Role.all
	end
	#create update
	#create delete
  	# PATCH/PUT /users/1
  	def update
  		@role = Role.find(params[:id])
	    if @role.update(role_params)
	      @role
	    else
	      error = Error.new(error_code: "1", error_description: "Unable to save role", error_list: @role.errors.full_messages)
	      render_error("unprocessable_entity", error)
	    end    
	end
  	# DELETE /tests/1
  	# DELETE /tests/1.json
  	def destroy
    	begin
      		@role = Role.find(params[:id])
      	if @role.destroy
        	render status: :ok, nothing: true
      	else
        	error = Error.new(error_code: "2", error_description: "Unable to delete role", error_list: @role.errors.full_messages)
        	render_error("unprocessable_entity", error)
      	end
    	rescue ActiveRecord::RecordNotFound
      		error = Error.new(error_code: "R_show", error_description: "Role Not Found")
      		render_error("not_found",error)
    	end    
  	end
	def show
		begin  			
			@role = Role.find(params[:id])
			if @role
				@role
			else
				render status: :not_found
			end
		rescue ActiveRecord::RecordNotFound
			error = Error.new(error_code: "R_show", error_description: "Role Not Found")
	  	render_error("not_found",error)
	  rescue ActiveRecord::ActiveRecordError
	    # handle other ActiveRecord errors
	    render status: :bad_request
	  rescue Exception
		 render status: :bad_request
	  end  		
	end
	private
		def role_params
			params.require(:role).permit(:name, :description, :policies)
	  	end
end

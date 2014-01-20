class UsersController < ApplicationController
	respond_to :json
 	def create
 		@user = User.new(user_params)
 		if @user.save
 			#send status: succsss
 			render status: :created, location: user_path(@user), nothing: true
 			#@user
 		 else
 		 	#send error status
 		 	 error = Error.new(error_code: "1", error_description: "Unable to save user", error_list: @user.errors.full_messages)
 		 	# render status: :unprocessable_entity, template: "errors/error"
 		 	render_error("unprocessable_entity", error)
 		 end
 	end	
	def index
		@users = User.all
	end
	def show
		begin  			
			@user = User.find(params[:id])
			if @user
				@user
			else
				render status: :not_found
			end
		rescue ActiveRecord::RecordNotFound
			error = Error.new(error_code: "U_show", error_description: "User Not Found")
	  	render_error("not_found",error)
	  rescue ActiveRecord::ActiveRecordError
	    # handle other ActiveRecord errors
	    render status: :bad_request
	  rescue Exception
		 render status: :bad_request
	  end  		
	end
	#create update
	#create delete
  # PATCH/PUT /users/1
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      @user
    else
      error = Error.new(error_code: "1", error_description: "Unable to save user", error_list: @user.errors.full_messages)
      render_error("unprocessable_entity", error)
    end    
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    begin
      @user = User.find(params[:id])
      if @user.destroy
        render status: :ok, nothing: true
      else
        error = Error.new(error_code: "2", error_description: "Unable to delete user", error_list: @user.errors.full_messages)
        render_error("unprocessable_entity", error)
      end
    rescue ActiveRecord::RecordNotFound
      error = Error.new(error_code: "U_show", error_description: "User Not Found")
      render_error("not_found",error)
    end    
  end
  	private
  		def user_params
  			params.require(:user).permit(:name, :email, :password, :password_confirmation)
  		end
      def set_user
        @user = User.find(params[:id])
      end
end

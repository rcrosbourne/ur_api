class UsersController < ApplicationController
	respond_to :json
	# def new
 #    	@user = User.new
 #  	end
  
 #  	def create
 #    	@user = User.new(params[:user])
 #    	if @user.save
 #      		redirect_to root_url, notice: "Thank you for signing up!"
 #    	else
 #      		render "new"
 #    	end
 #  	end
 	def create
 		@user = User.new(user_params)
 		if @user.save
 			#send status: succsss
 			render status: :created, location: user_path(@user)
 			#@user
 		 else
 		 	#send error status
 		 	render status: :bad_request, json: @user.errors.full_messages
 		 end
 	end	
  	def index
  		@users = User.all
  	end
  	private
  		def user_params
  			params.require(:user).permit(:name, :email, :password, :password_confirmation)
  		end
end

class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:notice] = "logged in"
			redirect_to user
		else
			flash.now[:alert] = "wrong details"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "loggeded out"
		redirect_to login_path
	end

end
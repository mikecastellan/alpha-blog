class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :require_user, except: [:show, :index]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def new
		@user = User.new
	end
	
	def show
	end

	def index
		@users = User.paginate(page: params[:page], per_page: 2)
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "Welcome #{@user.username}!"
			redirect_to articles_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:notice] = 'User was updated successfully'
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		@user.destroy
		session[:user_id] = nil
		flash[:notice] = "user and articles deleted"
		redirect_to articles_path
	end

	private
	def user_params
		params.require(:user).permit(:username,:email,:password)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def require_same_user
		if current_user != @user
			flash[:alert] = "you can only edit your own articles"
			redirect_to @article
		end
	end

end
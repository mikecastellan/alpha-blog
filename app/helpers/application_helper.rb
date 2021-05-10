module ApplicationHelper
	def gravatar_for(user)
		email = user.email.downcase
		hash = Digest::MD5.hexdigest(email)
		gurl = "https://www.gravatar.com/avatar/#{hash}"
		image_tag(gurl, alt: user.username)
	end
end

def current_user
	@current_user ||= User.find(session[:user_id]) if session[:user_id]
end

def logged_in?
	!!current_user
end

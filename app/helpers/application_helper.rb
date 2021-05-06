module ApplicationHelper
	def gravatar_for(user)
		email = user.email.downcase
		hash = Digest::MD5.hexdigest(email)
		gurl = "https://www.gravatar.com/avatar/#{hash}"
		image_tag(gurl, alt: user.username)
	end
end

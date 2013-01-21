module UsersHelper
	def gravatar_for(user)																  # Returns the Gravatar (http://gravatar.com/) for the given user.
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.email, class: "gravatar")
	end
	
	def get_user(userid)
		user = User.find_by_sql("SELECT * FROM users WHERE id = :user_id",  user_id: userid)
	end
end

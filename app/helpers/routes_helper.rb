module RoutesHelper
	def get_user(userid)
		result = User.find_by_sql("SELECT * FROM users WHERE id = :user_id",  user_id: userid)
	end
end

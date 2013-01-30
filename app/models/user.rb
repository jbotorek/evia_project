# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  
  #routes/events that created
  has_many :routes, dependent: :destroy
  has_many :events, dependent: :destroy
  
  #"following / followed" relationship
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  #want try a route relationship
  has_many :want_try_relationships, foreign_key: "wanter_id", dependent: :destroy
  has_many :wanted_routes, through: :want_try_relationships, source: :wanted_route
  
  #tried a route relationship
  has_many :tried_relationships, foreign_key: "trier_id", dependent: :destroy
  has_many :tried_routes, through: :want_try_relationships, source: :tried_route
  
  #personal information
  has_one :info, dependent: :destroy
  
  #comments for a route
  has_many :route_comment_relationships, foreign_key: "commenter_id", dependent: :destroy
  has_many :route_comments, through: :route_comment_relationships, source: :route_comment
  
  #attends an event
  has_many :event_attends, foreign_key: "attendee_id", dependent: :destroy
  has_many :attend_events, through: :event_attends, source: :attend_event
  
  #comments for an event
  has_many :event_comment_relationships, foreign_key: "commenter_id", dependent: :destroy
  has_many :event_comments, through: :event_comment_relationships, source: :event_comment
  
  
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: 	true,
					format: 	{ with: VALID_EMAIL_REGEX },
					uniqueness: { case_sensitive: false }
					
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  #method showing all other posts - from other users
  def showcase
	showcase = Route.from_users_followed_by(self)
  end
  
  def showcase_events
	showcase = Event.from_users_followed_by(self)
  end
  
  # methods for following other users
  def following?(other_user)
	relationships.find_by_followed_id(other_user.id)
  end
  
  def follow!(other_user)
	relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
	  relationships.find_by_followed_id(other_user.id).destroy if self.following?(other_user)
  end
  
  # decide if the user has already provided some personal information
  def has_info?
    Info.find_by_user_id(self.id)
  end
    
  def want_try?(route)
	want_try_relationships.find_by_wanted_route_id(route.id)
  end
  
  def want_try!(route)
	want_try_relationships.create!(route_id: route.id)
  end
  
  def not_want_try!(route)
	want_try_relationships.find_by_wanted_route_id(route).destroy 
  end
  
  def tried?(route)
	tried_relationships.find_by_tried_route_id(route.id)
  end
  
  def not_tried!(route)
	tried_relationships.find_by_tried_route_id(route).destroy 
  end
  
  def attend?(event)
	event_attends.find_by_attend_event_id(event.id)
  end
  
  def unattend!(event)
	event_attends.find_by_attend_event_id(event.id).destroy
  end
  
  private
  def create_remember_token
	self.remember_token = SecureRandom.urlsafe_base64
  end
  
  
end

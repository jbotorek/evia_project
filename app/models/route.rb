# == Schema Information
#
# Table name: routes
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  title            :string(255)
#  description      :text
#  map              :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  activity_type_id :integer
#

class Route < ActiveRecord::Base
  attr_accessible :description, :map, :title, :user_id, :activity_type_id, :assets_attributes, :criterion
  
  # user that created a route
  belongs_to :user
  # all events where this route is used
  has_many :events
  
  # users that want to try a route
  has_many :want_try_relationships, foreign_key: "wanted_route_id", dependent: :destroy
  has_many :wanters, through: :want_try_relationships, source: :wanter
  
  # users that tried a route
  has_many :tried_relationships, foreign_key: "tried_route_id", dependent: :destroy
  has_many :triers, through: :tried_relationships, source: :trier
  
  # what type is a route
  has_many :route_activity_relation, foreign_key: "route_id", dependent: :destroy
  has_many :activity_types, through: :route_activity_relation, source: :activity_type
  
  # comments for a route
  has_many :route_comment_relationships, foreign_key: "route_id", dependent: :destroy
  has_many :commenters, through: :route_comment_relationships, source: :commenter
  
  
  #IMAGES
  has_many :assets, :dependent => :destroy
  accepts_nested_attributes_for :assets
    
  default_scope order: 'routes.created_at DESC'
  
  validates :user_id, presence: true
  validates :description, presence: true
  validates :map, presence: true
  validates :title, presence:true, length: { minimum: 1, maximum: 160 }
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
  
  def all_comments(routeid)
	all_comments = Route.find_by_sql(["SELECT * FROM route_comment_relationships WHERE (route_id = ?)", routeid])
  end
  
  
  

end

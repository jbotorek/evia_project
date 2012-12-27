# == Schema Information
#
# Table name: routes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string(255)
#  description :text
#  map         :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Route < ActiveRecord::Base
  attr_accessible :description, :map, :title
  
  belongs_to :user
  
  has_many :want_try_relationships, foreign_key: "wanted_route_id", dependent: :destroy
  has_many :wanters, through: :want_try_relationships, source: :wanter
  
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
  
  

end

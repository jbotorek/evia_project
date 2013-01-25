# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  route_id      :integer
#  title         :string(255)
#  description   :text
#  time          :datetime
#  event_type_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Event < ActiveRecord::Base
  attr_accessible :description, :event_type_id, :route_id, :time, :title, :user_id, :id
  
  #User that created the event
  belongs_to :user 
  #Route that is used in the event
  belongs_to :route
  
  validates :user_id, presence: true
  validates :route_id, presence: true
  validates :event_type_id, presence: true
  validates :description, presence: true
  validates :time, presence: true
  validates :title, presence:true, length: { minimum: 1, maximum: 160 }
  
  default_scope order: 'events.created_at DESC'
  
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
  
end

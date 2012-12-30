# == Schema Information
#
# Table name: want_try_relationships
#
#  id              :integer          not null, primary key
#  wanter_id       :integer
#  wanted_route_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class WantTryRelationship < ActiveRecord::Base
  attr_accessible :wanter_id, :wanted_route_id
    
  belongs_to :wanter, class_name: "User"
  belongs_to :wanted_route, class_name: "Route"
  
  validates :wanter_id, presence: true
  validates :wanted_route_id, presence: true
  
end

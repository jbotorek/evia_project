# == Schema Information
#
# Table name: tried_relationships
#
#  id             :integer          not null, primary key
#  trier_id       :integer
#  tried_route_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class TriedRelationship < ActiveRecord::Base
  attr_accessible :tried_route_id, :trier_id
  
  belongs_to :trier, class_name: "User"
  belongs_to :tried_route, class_name: "Route"
  
  validates :trier_id, presence: true
  validates :tried_route_id, presence: true  
end

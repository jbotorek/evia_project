class RouteActivityRelation < ActiveRecord::Base
  attr_accessible :activity_type_id, :route_id
  
  belongs_to :activity_type, class_name: "ActivityType"
  belongs_to :route, class_name: "Route"
  
  validates :activity_type_id, presence: true
  validates :route_id, presence: true  
end

# == Schema Information
#
# Table name: activity_types
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ActivityType < ActiveRecord::Base
  attr_accessible :description, :title
  
  validates :title, presence: true
  validates :description, presence: true
  
  has_many :route_activity_relation, foreign_key: "activity_type_id", dependent: :destroy
  has_many :routes, through: :route_activity_relation, source: :route
end

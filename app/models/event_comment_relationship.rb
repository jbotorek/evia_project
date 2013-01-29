# == Schema Information
#
# Table name: event_comment_relationships
#
#  id           :integer          not null, primary key
#  commenter_id :integer
#  event_id     :integer
#  text         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class EventCommentRelationship < ActiveRecord::Base
  attr_accessible :commenter_id, :event_id, :text
    
  belongs_to :commenter, class_name: "User"
  belongs_to :event_comment, class_name: "Event"
  
  validates :commenter_id, presence: true
  validates :event_id, presence: true
  validates :text, presence: true
  validates :text, length: { maximum: 250 }
end

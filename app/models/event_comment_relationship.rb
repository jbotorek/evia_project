class EventCommentRelationship < ActiveRecord::Base
  attr_accessible :commenter_id, :event_id, :text
    
  belongs_to :commenter, class_name: "User"
  belongs_to :event_comment, class_name: "Event"
  
  validates :commenter_id, presence: true
  validates :event_id, presence: true
  validates :text, presence: true
  validates :text, length: { maximum: 250 }
end

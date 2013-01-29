# == Schema Information
#
# Table name: event_attends
#
#  id              :integer          not null, primary key
#  attendee_id     :integer
#  attend_event_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class EventAttend < ActiveRecord::Base
  attr_accessible :attend_event_id, :attendee_id
    
  belongs_to :attendee, class_name: "User"
  belongs_to :attend_event, class_name: "Event"
  
  validates :attend_event_id, presence: true
  validates :attendee_id, presence: true
end

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

require 'spec_helper'

describe EventAttend do
  pending "add some examples to (or delete) #{__FILE__}"
end

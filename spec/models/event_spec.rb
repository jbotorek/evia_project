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

require 'spec_helper'

describe Event do
  pending "add some examples to (or delete) #{__FILE__}"
end

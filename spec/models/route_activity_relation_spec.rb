# == Schema Information
#
# Table name: route_activity_relations
#
#  id               :integer          not null, primary key
#  route_id         :integer
#  activity_type_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe RouteActivityRelation do
  pending "add some examples to (or delete) #{__FILE__}"
end

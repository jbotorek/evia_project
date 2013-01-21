# == Schema Information
#
# Table name: route_comment_relationships
#
#  id           :integer          not null, primary key
#  commenter_id :integer
#  route_id     :integer
#  text         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe RouteCommentRelationships do
  pending "add some examples to (or delete) #{__FILE__}"
end

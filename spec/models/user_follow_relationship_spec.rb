# == Schema Information
#
# Table name: user_follow_relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe UserFollowRelationship do
  pending "add some examples to (or delete) #{__FILE__}"
end

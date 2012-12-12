# == Schema Information
#
# Table name: routes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string(255)
#  description :text
#  map         :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Route do
  pending "add some examples to (or delete) #{__FILE__}"
end

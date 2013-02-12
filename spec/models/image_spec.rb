# == Schema Information
#
# Table name: images
#
#  id            :integer          not null, primary key
#  description   :text
#  file          :string(255)
#  attachable_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Image do
  pending "add some examples to (or delete) #{__FILE__}"
end

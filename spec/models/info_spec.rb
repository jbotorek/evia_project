# == Schema Information
#
# Table name: infos
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string(255)
#  surname      :string(255)
#  gender       :string(255)
#  street       :string(255)
#  house_number :string(255)
#  town         :string(255)
#  bio          :text
#  image        :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Info do
  pending "add some examples to (or delete) #{__FILE__}"
end

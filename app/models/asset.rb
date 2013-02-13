# == Schema Information
#
# Table name: assets
#
#  id                 :integer          not null, primary key
#  route_id           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  user_id            :integer
#

class Asset < ActiveRecord::Base
  attr_accessible :route_id, :image_file_name, :image, :user_id
  
  belongs_to :route, :polymorphic => true 
  has_attached_file :image, 
					:url  => "/assets/routes/:id/:style/:basename.:extension",
					:path => ":rails_root/public/assets/routes/:id/:style/:basename.:extension"
					
  validates :image_file_name, presence: true
  
  #method used when saving new image/images - according to the given route it returns
  #array of images without user_id provided
  def notUsersSet(routeid)
    notUsers = Asset.find_by_sql(["SELECT * FROM assets WHERE (route_id = ?) AND (user_id is null)",
	routeid])
  end
  
end

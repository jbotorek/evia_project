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
  attr_accessible :route_id, :image_file_name, :image, :user_id, :image_content_type
  
  belongs_to :route, :polymorphic => true 
  has_attached_file :image, 
					:url  => "/assets/routes/:id/:basename.:extension",
					:path => ":rails_root/app/assets/images/photogalleries/:id/:basename.:extension"
	
  before_create :randomize_file_name
  
  validates :image_file_name, presence: true
  
  #method used when saving new image/images - according to the given route it returns
  #array of images without user_id provided
  def notUsersSet(routeid)
    notUsers = Asset.find_by_sql(["SELECT * FROM assets WHERE (route_id = ?) AND (user_id is null)",
	routeid])
  end  
  
  def randomize_file_name
    extension = File.extname(image_file_name).downcase
    self.image.instance_write(:file_name, "#{SecureRandom.hex(16)}#{extension}")
  end
  
  def is_owner?(user)
	user.id == self.user_id
  end
  
end

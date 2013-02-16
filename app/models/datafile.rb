# == Schema Information
#
# Table name: datafiles
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

#Simple model that saves images into specific file location
class Datafile < ActiveRecord::Base
  def self.save(image,route_id,user_id,savedphoto_id, encoded_name)
	Dir.mkdir "app/assets/images/photogalleries/"+savedphoto_id.to_s
    name =  encoded_name
    directory = "app/assets/images/photogalleries/"+savedphoto_id.to_s
    path = File.join(directory, name)    # create the file path
    File.open(path, "wb") { |f| f.write(image.read) }				# write the file
  end
end

class Photo < ActiveRecord::Base
  belongs_to :holder, :polymorphic => true
  before_save :filename_to_permalink
  
  has_attached_file :photo, :styles => { :super_small => "50x50>", :small => "150x150>", :medium => "250x250>", :big => "425x320#", :small_slice => "200x95#", :big_slice => "696x250#" },
                    :url  => "/system/photos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/photos/:id/:style/:basename.:extension"
  
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 10.megabytes, :if => Proc.new { |photo| not photo.photo.nil? }
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png'], :if => Proc.new { |photo| not photo.photo.nil? }
  
  private
  
  def filename_to_permalink
    extension = File.extname(photo_file_name).downcase
    file_name = photo_file_name.sub extension, ''
    self.photo.instance_write(:file_name, file_name.to_permalink + extension)
  end
  
end

class ExternalContent < ActiveRecord::Base
  belongs_to :external_content_kind
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  
  before_update :check_for_missusage
  
  has_attached_file :photo, :styles => { :super_small => "50x50>", :small => "150x150>", :medium => "250x250>", :big => "470x470>" },
                    :url  => "/system/external_content/photos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/external_content/photos/:id/:style/:basename.:extension"
  
  validates_presence_of :name, :title


  class << self
    def is_user_authorized_to_edit?(user)
      User.external_authors.include?(user) or user.admin?
    end
  end
  
  def to_s
    name
  end
  
  def content_to_html
    RedCloth.new(content).to_html.html_safe unless content.nil?
  end
  
  
  private
  def check_for_missusage
    
  end
end

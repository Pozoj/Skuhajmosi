class User < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :user_kind_id

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  #devise :database_authenticatable, :validatable # :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :trackable
  
  has_many :photos, :as => :holder, :dependent => :destroy
  has_many :recipes, :foreign_key => "author_id"
  has_many :external_contents, :foreign_key => "author_id"
  belongs_to :user_kind

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  scope :admins, where(:admin => true)
  
  with_options :if => :should_validate_password? do |v|
    v.validates_presence_of :password
    v.validates_confirmation_of :password
    v.validates_length_of :password, :within => 6..128
  end
  
  def should_validate_password?
    new_record? or not password.blank?
  end
  
  def full_name
    if first_name and last_name
      "#{first_name} #{last_name}"
    elsif first_name
      first_name
    else
      "User##{id}"
    end
  end
  
  def access_rights
    return user_kind.access_rights if user_kind
  end
  
  def to_s
    full_name
  end
end

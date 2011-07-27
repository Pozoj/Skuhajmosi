class User < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :user_kind_id, :user_kind

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  #devise :database_authenticatable, :validatable # :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :trackable
  
  has_many :photos, :as => :holder, :dependent => :destroy
  #has_many :recipes, :foreign_key => "author_id"
  has_many :external_contents, :foreign_key => "author_id"
  #belongs_to :user_kind

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => Configuration::EMAIL_CHECK #/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  scope :admins, where(:admin => true)
  
  with_options :if => :should_validate_password? do |v|
    v.validates_presence_of :password
    v.validates_confirmation_of :password
    v.validates_length_of :password, :within => 6..128
  end
  
  def should_validate_password?
    new_record? or not password.blank?
  end
  
  def user_kind
    UserKind.find(user_kind_id)
  end
  
  def user_kind=(uk)
    self.user_kind_id = UserKind.find(uk).id if UserKind.find(uk)
  end
  
  class << self
    def external_authors
      self.where(:user_kind_id => UserKind.external)
    end
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def access_rights
    return AccessRight.where(:user_kind_id => user_kind_id) if user_kind_id.present?
    return []
  end
  
  def to_s
    full_name
  end
end

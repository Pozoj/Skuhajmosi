class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :validatable # :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :first_name, :last_name

  has_many :recipes
  belongs_to :kind, :class_name => "UserKind"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me
  
  
  def full_name
    if first_name and last_name
      "#{first_name} #{last_name}"
    elsif first_name
      first_name
    else
      "User##{id}"
    end
  end
  
  def to_s
    full_name
  end
end

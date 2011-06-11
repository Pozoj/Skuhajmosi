class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    if user.admin?
      can :manage, :all
    elsif user and user.user_kind and user.access_rights.any?
      can :read, :all
      cannot :read, [AccessRight, UserKind, User]
      for access_right in user.user_kind.access_rights
        can access_right.rights_sym, access_right.models_class_name
      end
    else
      can :read, :all
      cannot :read, [AccessRight, UserKind, User]
      cannot :destroy, [Photo, Recipe]
      cannot :manage, AccessRight
      cannot :manage, UserKind
      cannot :manage, User
    end
  end
end

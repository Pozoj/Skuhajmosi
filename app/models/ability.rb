class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
        
    if user.admin? # User is an admin
      can :manage, :all
    elsif user and user.user_kind and user.access_rights.any? # User has defined access rights
      can :read, :all
      cannot :read, [AccessRight, UserKind, User]
      for access_right in user.access_rights
        if user.user_kind.external? and access_right.models_class_name == ExternalContent
          can access_right.rights_sym, access_right.models_class_name, :author_id => user.id
        else
          can access_right.rights_sym, access_right.models_class_name
        end
      end
    else # User is a visitor
      can :read, :all
      can :create, OriginalRecipe
      cannot :read, [AccessRight, UserKind, User, OriginalRecipe]
      cannot :destroy, [Photo, Recipe]
      cannot :manage, AccessRight
      cannot :manage, UserKind
      cannot :manage, User
    end
  end
end

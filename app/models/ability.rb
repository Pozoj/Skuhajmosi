class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
        
    if user.admin?
      can :manage, :all
    elsif user and user.user_kind and user.access_rights.any?
      external_author_user_kind = UserKind.external_author_user_kind
      can :read, :all
      cannot :read, [AccessRight, UserKind, User]
      for access_right in user.user_kind.access_rights
        if user.user_kind == external_author_user_kind and access_right.models_class_name == ExternalContent
          can access_right.rights_sym, access_right.models_class_name, :author_id => user.id
        else
          can access_right.rights_sym, access_right.models_class_name
        end
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

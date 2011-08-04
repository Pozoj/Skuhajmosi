module ExternalsHelper
  def current_user_is_the_author?(content)
    current_user and (admin? or (UserKind.find(current_user.user_kind_id).external? and content and content.author_id == current_user.id))
  end
end
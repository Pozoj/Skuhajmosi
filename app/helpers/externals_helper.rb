module ExternalsHelper
  def current_user_is_the_author?(content)
    current_user and current_user.user_kind == UserKind.external_author_user_kind and content and content.author_id == current_user.id
  end
end
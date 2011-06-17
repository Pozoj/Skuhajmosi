module ExternalContentKindsHelper
  def external_contents_link_list(resource)
    list_items = resource.external_contents(true).order("title ASC").collect do |external_content|
      list_item = [ link_to(external_content, external_path(external_content) )]
      if can? :update, external_content
        if admin?
          list_item << link_to( "Uredi", edit_external_content_kind_external_content_path(external_content.external_content_kind, external_content) )
        else
          list_item << link_to( "Uredi", edit_external_path(external_content) )
        end
      end
      if can? :destroy, external_content
        list_item << link_to( "Izbriši", [external_content.external_content_kind, external_content], :method => :delete, :confirm => destroy_confirmation(external_content) )
      end
      content_tag(:li, list_item.join(' | ').html_safe) 
    end.join.html_safe
    content_tag(:ul, list_items, :class => "external-content-list")
  end
end
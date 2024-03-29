module ApplicationHelper
  def n(number)
    number_to_human(number,  :precision => 2, :separator => ',')
  end
  
  def helpas(user_help)
    content_tag(:div, :class => "help") do
      content_tag(:h3, "Pomoč") +
      (can?(:manage, Helpster) ? link_to("Uredi pomoč", edit_helpster_path(user_help)) : "") +
      content_tag(:p, user_help.help)
    end
  end
  
  def helpster(container_id)
    if Container.find(container_id).present? and current_user.present? and (current_user.user_kind_id.present? or current_user.admin?)
      user_kind_id = current_user.admin ? "admin" : current_user.user_kind_id
      user_help = Helpster.find_by_user_kind_id_and_container_id(user_kind_id, container_id)
      
      return unless user_help.present?
      return helpas(user_help)
    end
  end
  
  def association_link_list(resource, associations)
    list_items = resource.send(associations).collect do |associated_item|
      content_tag(:li, link_to(associated_item, associated_item)) 
    end.join.html_safe
    content_tag(:ul, list_items, :class => "#{associations}-list")
  end
  
  def array_to_link_list(array_of_objects, title = "")
    list_items = array_of_objects.collect do |obj|
      content_tag(:li, link_to(obj, obj)) 
    end.join.html_safe
    content_tag(:ul, list_items, :class => "#{title}-list")
  end
  
  def array_to_unordered_list(array_of_objects)
    list_items = array_of_objects.collect do |obj|
      content_tag(:li, obj.to_s) 
    end.join.html_safe
    content_tag(:ul, list_items)
  end
  
  
  def collection_list_renderer(collection)
    if Array(collection).any?
      content_tag(:div, content_tag(:ul, render(collection)), :class => "collection-list")
    else
      tag("div", :class => "collection-list")
    end
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :pick => pick, :recipe_kind => recipe_kind }, {:class => css_class}
  end
  
  def can_update_destroy_resource_photo(resource)
    can?(:update, resource) or can?(:destroy, resource) or can?(:create, Photo) or can?(:destroy, Photo)
  end
  
  def usable_external_content_kinds
    ExternalContentKind.order(:name).reject {|content_kind| content_kind.external_contents.empty? }
  end
  
  
  class Override < Prawn::Document
    def initialize(opts={})
      super(opts)
      # text "I can override the rendering class"
      # text "This lets me use pre-built reports and other wrappers around Prawn::Document"
    end
  end
  
end

module ProductFirmsHelper
  def products_link_list(resource)
    association_link_list(resource, "products")
  end
end

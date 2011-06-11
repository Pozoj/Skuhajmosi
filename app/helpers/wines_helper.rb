module WinesHelper
  def wines_link_list(resource)
    association_link_list(resource, "wines")
  end
end
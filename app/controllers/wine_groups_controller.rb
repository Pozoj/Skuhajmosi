class WineGroupsController < InheritedResources::Base
  load_and_authorize_resource
  
  def destroy
    destroy! { wines_path }
  end
end
class HelpstersController < InheritedResources::Base
  load_and_authorize_resource
  
  def create
    create! { helpsters_path }
  end
  
  def update
    update! { helpsters_path }
  end
end

class AboutsController < InheritedResources::Base
  load_and_authorize_resource
  
  def create
    create! { abouts_path }
  end
  
  def update
    update! { abouts_path }
  end
end
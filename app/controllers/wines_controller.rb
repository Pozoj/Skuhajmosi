class WinesController < InheritedResources::Base
  load_and_authorize_resource
  
  def index
    @wine_colors = WineColor.order(:name)
    @wine_kinds  = WineKind.order(:name)
    @wine_groups = WineGroup.order(:name)
    
    index!
  end
  
  def new
    @wine = Wine.new(:author_id => current_user.id)
  end
    
end
class WinesController < InheritedResources::Base
  load_and_authorize_resource

  def new
    @wine = Wine.new(:author_id => current_user.id)
  end
    
end
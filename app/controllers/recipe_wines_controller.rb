class RecipeWinesController < InheritedResources::Base
  load_and_authorize_resource
  belongs_to :recipe
  
  def create
    create! { parent_path }
  end
  
  def update
    update! { parent_path }
  end
  
  def destroy
    destroy! { parent_path }
  end
  
end
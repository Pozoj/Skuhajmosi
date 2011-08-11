class CookingSchoolsController < InheritedResources::Base
  load_and_authorize_resource
    
  private
  
  def collection
    @cooking_schools = CookingSchool.page(params[:post_page])
  end
end
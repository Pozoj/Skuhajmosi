class AccessRightsController < InheritedResources::Base
  load_and_authorize_resource
  
  def new
    @access_right = AccessRight.new
    @access_right.user_kind = parent
  end
  
  def create
    create! { user_kinds_path }
  end
  
  def update
    update! { user_kinds_path }
  end
  
  def destroy
    destroy! { user_kinds_path }
  end

  def parent
    @parent ||= UserKind.find(params[:user_kind_id]).id if params[:user_kind_id].present? 
  end
end
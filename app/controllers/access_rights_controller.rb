class AccessRightsController < InheritedResources::Base
  load_and_authorize_resource
  
  belongs_to :user_kind
  
  def new
    @access_right = AccessRight.new
    @access_right.user_kind = parent
  end
  
  def create
    create! { user_kind_path(parent) }
  end

  def update
    update! { user_kind_path(parent) }
  end

  def destroy
    destroy! { user_kind_path(parent) }
  end


end
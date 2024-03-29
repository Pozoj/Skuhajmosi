class ExternalContentsController < InheritedResources::Base
  load_and_authorize_resource
  
  belongs_to :external_content_kind
  
  def new
    @external_authors = User.external_authors
    new!
  end
  
  def edit
    @external_authors = User.external_authors
    edit!
  end
  
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
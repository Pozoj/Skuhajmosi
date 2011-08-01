class ContactsController < InheritedResources::Base
  load_and_authorize_resource
  
  def create
    create! { contacts_path }
  end
  
  def update
    update! { contacts_path }
  end
  
end
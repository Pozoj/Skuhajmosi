class CommentsController < InheritedResources::Base
  load_and_authorize_resource
  skip_load_resource :only => [:new, :create]
  skip_before_filter :authenticate_user!, :only => [:new, :create]
  
  def create
    create!(:notice => "Uspešno ste oddali komentar. Hvala Vam za Vaše mnenje.") { root_path }
  end
end
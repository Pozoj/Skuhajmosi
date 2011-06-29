class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :body_attrs, :admin?
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :export_i18n_messages
  
  # Cancan
  check_authorization
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :error => exception.message
  end
  
  protected
  def admin?
    current_user and current_user.admin
  end
      
  def body_attrs
    klass = controller_name
    klass += " signed_out" unless current_user
    @body_attrs = {:id => "#{controller_name}-#{action_name}", :class => klass}
  end
  
  def export_i18n_messages
    SimplesIdeias::I18n.export! if Rails.env.development?
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
end

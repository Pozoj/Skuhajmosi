class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :body_attrs
  before_filter :authenticate_user!, :export_i18n_messages
  
  protected
    
  def body_attrs
    klass = controller_name
    klass += " signed_out" unless current_user
    @body_attrs = {:id => "#{controller_name}-#{action_name}", :class => klass}
  end
  
  def export_i18n_messages
    SimplesIdeias::I18n.export! if Rails.env.development?
  end
end
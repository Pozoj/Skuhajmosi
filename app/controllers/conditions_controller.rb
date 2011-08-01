class ConditionsController < InheritedResources::Base
  load_and_authorize_resource
  
  def create
    create! { conditions_path }
  end
  
  def update
    update! { conditions_path }
  end
  
end
class ProductsController < InheritedResources::Base
  load_and_authorize_resource
end

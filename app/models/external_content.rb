class ExternalContent < ActiveRecord::Base
  belongs_to :external_content_kind
  belongs_to :author
end

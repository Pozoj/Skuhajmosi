require 'rexml/document'

Dir[Rails.root + 'lib/**/*.rb'].each do |file|
  require file
end
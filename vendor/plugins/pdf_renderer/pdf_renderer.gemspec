# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "pdf_renderer"
  s.summary = "Use it like a pro in the controller \n
                  respond_to { |format| format.pdf { render :pdf => 'contents' } } \n
               Yeah."
  s.description = "Renders PDFs like a mofo."
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version = "0.0.1"
end
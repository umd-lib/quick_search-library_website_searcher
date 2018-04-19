$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "quick_search/library_website_searcher/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "quick_search-library_website_searcher"
  s.version     = QuickSearch::LibraryWebsiteSearcher::VERSION
  s.authors     = ["David P. Steelman"]
  s.email       = ["dsteelma@umd.edu"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of QuickSearch::LibraryWebsiteSearcher."
  s.description = "TODO: Description of QuickSearch::LibraryWebsiteSearcher."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.5"

  s.add_development_dependency "sqlite3"
end

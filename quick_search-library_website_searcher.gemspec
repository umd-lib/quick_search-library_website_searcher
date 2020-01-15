# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'quick_search/library_website_searcher/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'quick_search-library_website_searcher'
  s.version     = QuickSearchLibraryWebsiteSearcher::VERSION
  s.authors     = ['UMD Libraries']
  s.email       = ['lib-ssdr@umd.edu']
  s.homepage    = 'https://www.lib.umd.edu/'
  s.summary     = 'UMD Library Website searcher for NCSU Quick Search'
  s.description = 'UMD Library Website searcher for NCSU Quick Search.'
  s.license     = 'Apache 2.0'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'kaminari'
  s.add_dependency 'quick_search-core', '~> 0'
  s.add_dependency 'rsolr', '2.2.1'
  s.add_development_dependency 'rubocop', '= 0.78.0'
  s.add_development_dependency 'rubocop-rails'
  # sqlite3 loaded for testing with the "dummy" application
  s.add_development_dependency 'sqlite3'
end

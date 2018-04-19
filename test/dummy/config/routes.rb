Rails.application.routes.draw do
  mount QuickSearch::LibraryWebsiteSearcher::Engine => "/quick_search-library_website_searcher"
end

Rails.application.routes.draw do
  mount QuickSearchLibraryWebsiteSearcher::Engine => "/quick_search-library_website_searcher"
end

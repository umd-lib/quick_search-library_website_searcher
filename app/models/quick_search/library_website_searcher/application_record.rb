module QuickSearch
  module LibraryWebsiteSearcher
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end

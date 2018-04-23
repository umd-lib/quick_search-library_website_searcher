module QuickSearch
  # QuickSearch seacher for UMD Library Website
  class LibraryWebsiteSearcher < QuickSearch::Searcher
    def search
      resp = @http.get(search_url)
      @response = JSON.parse(resp.body)
    end

    def results # rubocop:disable Metrics/MethodLength
      if results_list
        results_list
      else
        @results_list = []

        search_result_list = @response['resultList']
        search_result_list.each do |value|
          result = OpenStruct.new
          result.link = get_hyperlink(value)
          result.title = get_title(value)
          result.description = get_description(value)
          @results_list << result
        end

        @results_list
      end
    end

    def search_url
      QuickSearch::Engine::LIBRARY_WEBSITE_CONFIG['search_url'] +
        QuickSearch::Engine::LIBRARY_WEBSITE_CONFIG['query_params'] +
        http_request_queries['not_escaped']
    end

    def total
      @response['totalCount']
    end

    def loaded_link
      QuickSearch::Engine::LIBRARY_WEBSITE_CONFIG['loaded_link'] + http_request_queries['uri_escaped']
    end

    private

      # Returns the hyperlink to use
      def get_hyperlink(result)
        links = result['links']
        links[0]['Link']['href'] if links.any?
      end

      # Returns the string to use for the result title
      def get_title(result)
        title = result['title']
        display_name = result['displayName']
        name = result['name']

        return title if title.present?
        return display_name if display_name.present?
        name
      end

      # Returns the string to use for the result description
      def get_description(result)
        summary = result['summary']
        description = result['description']

        return summary if summary.present?
        description
      end
  end
end

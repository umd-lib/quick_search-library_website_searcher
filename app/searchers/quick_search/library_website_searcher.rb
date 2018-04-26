# frozen_string_literal: true

module QuickSearch
  # QuickSearch seacher for UMD Library Website
  class LibraryWebsiteSearcher < QuickSearch::Searcher
    include QuickSearchLibraryWebsiteSearcher::Engine.routes.url_helpers

    def search
      resp = @http.get(search_url)
      @response = JSON.parse(resp.body)
      @total = @response['totalCount']
    end

    def results
      return results_list if results_list
      @results_list = @response['resultList'].map do |value|
        OpenStruct.new(link: get_hyperlink(value), title: get_title(value),
                       description: get_description(value))
      end

      @results_list
    end

    def search_url
      QuickSearch::Engine::LIBRARY_WEBSITE_CONFIG['search_url'] +
        base_query_params +
        http_request_queries['not_escaped']
    end

    def base_query_params
      return QuickSearch::Engine::LIBRARY_WEBSITE_CONFIG['query_params'] if @per_page.blank?
      "?pageSize=#{@per_page}&pageNumber=#{@page}&q="
    end

    def total
      @response['totalCount']
    end

    def loaded_link
      root_url(only_path: true, q: http_request_queries['uri_escaped'])
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

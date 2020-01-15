# frozen_string_literal: true

require 'rsolr'

module QuickSearch
  # QuickSearch searcher for UMD Library Website
  class LibraryWebsiteSearcher < QuickSearch::Searcher
    def search
      search_term = http_request_queries['uri_escaped']
      search_term = '*' if search_term.blank?

      query_params = base_query_params
      query_template = base_query_params['q_template']
      query_term = query_template.gsub('SEARCH_TERM', search_term)
      query_params['q'] = query_term

      solr = RSolr.connect url: search_url
      @response = solr.get 'select', params: query_params

      @total = total
    end

    def results
      return results_list if results_list

      @results_list = @response['response']['docs'].map do |doc|
        OpenStruct.new(
          link: get_hyperlink(doc), title: get_title(doc), description: get_description(doc),
          item_format: 'web_page'
        )
      end

      @results_list
    end

    def search_url
      QuickSearch::Engine::LIBRARY_WEBSITE_CONFIG['search_url']
    end

    def base_query_params
      query_params = QuickSearch::Engine::LIBRARY_WEBSITE_CONFIG['query_params']
      return default_query_params if @per_page.blank?

      query_params['rows'] = @per_page
      query_params['start'] = @offset
      query_params
    end

    def total
      @response['response']['numFound']
    end

    def loaded_link
      QuickSearch::Engine::LIBRARY_WEBSITE_CONFIG['loaded_link'] +
        percent_encoded_raw_user_search_query
    end

    # Returns the percent-encoded search query entered by the user, skipping
    # the default QuickSearch query filtering
    def percent_encoded_raw_user_search_query
      CGI.escape(@q)
    end

    private

      # Returns the hyperlink to use
      def get_hyperlink(result)
        result['url']
      end

      # Returns the string to use for the result title
      def get_title(result)
        result['title']
      end

      # Returns the string to use for the result description
      def get_description(result)
        description = result['documentContent']
        content_tag(:div, content_tag(:p, description), class: ['block-with-text'])
      end
  end
end

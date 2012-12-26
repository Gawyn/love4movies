module TheMovieDB
  class Client
    attr_reader :base, :api_key

    include HTTParty
    base_uri "http://api.themoviedb.org/3"
    headers 'accept' => 'application/json' 
    format :json

    def initialize(api_key)
      @api_key = api_key
    end

    def search(title)
      url = "/search/movie?"
      options = { :query => title, :api_key => @api_key }
      response = self.class.get(url + options.to_query)
      parsed_response = response.parsed_response
      total_pages = parsed_response["total_pages"]

      (2..total_pages).inject(parsed_response["results"]) do |res, page|
        options[:page] = page
        page_results = self.class.get(url + options.to_query).parsed_response["results"]
        res + page_results
      end
    end

    def get_movie(id, lang = nil)
      url = "/movie/#{id}?"
      options = { :api_key => @api_key }
      options = options.merge(:language => lang) if lang
      self.class.get(url + options.to_query).parsed_response
    end
  end
end

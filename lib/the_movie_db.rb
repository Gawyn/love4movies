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

    def search(title, adult = nil)
      url = "/search/movie?"
      options = { :query => title, :api_key => @api_key }
      options = options.merge( :include_adult => adult ) if adult

      response = self.class.get(url + options.to_query)
      parsed_response = response.parsed_response
      total_pages = parsed_response["total_pages"]

      if total_pages && total_pages.is_a?(Integer)
        (2..total_pages).inject(parsed_response["results"]) do |res, page|
          options[:page] = page
          page_results = self.class.get(url + options.to_query).parsed_response["results"] || []
          res + page_results
        end
      end
    end

    def get_configuration
      url = "/configuration?"
      options = { :api_key => @api_key }
      self.class.get(url + options.to_query).parsed_response
    end

    def get_movie(id, lang = nil)
      url = "/movie/#{id}?"
      options = { :api_key => @api_key }
      options = options.merge(:language => lang) if lang
      self.class.get(url + options.to_query).parsed_response
    end

    def get_images(id)
      url = "/movie/#{id}/images?"
      options = { :api_key => @api_key }
      self.class.get(url + options.to_query).parsed_response
    end

    def get_cast(id)
      url = "/movie/#{id}/casts?"
      options = { :api_key => @api_key }
      self.class.get(url + options.to_query).parsed_response
    end

    def get_person(id)
      url = "/person/#{id}?"
      options = { :api_key => @api_key }
      self.class.get(url + options.to_query).parsed_response
    end

    def get_person_images(id)
      url = "/person/#{id}/images?"
      options = { :api_key => @api_key }
      self.class.get(url + options.to_query).parsed_response
    end

    def get_person_credits(id)
      url = "/person/#{id}/credits?"
      options = { :api_key => @api_key }
      self.class.get(url + options.to_query).parsed_response
    end
  end
end

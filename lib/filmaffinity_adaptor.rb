class FilmaffinityAdaptor
  class << self
    require "filmaffinity"

    def import_ratings(user_id, fa_user_id)
      ratings = Filmaffinity.get_user_ratings(fa_user_id)

      process_ratings
    end

    def process_ratings(user_id, ratings)
      ratings.each do |rating|
        process_rating(user_id, rating)
      end
    end

    def process_rating(user_id, rating)
      @movies = Movie.standard_search(process_title(rating["title"])).results
      
      unless @movies.empty?
        movie = @movies.detect { |m| m.release_date.try(:year).to_i == rating["year"].to_i } || @movies.detect { |m| m.decorate.directors_names == rating["director"] }

        if movie
          if Rating.find_by_user_id_and_movie_id(user_id, movie.id).nil?
            Rating.create(
              user_id: user_id,
              movie_id: movie.id,
              value: rating["rating"]
            )
          end
        end
      end
    end

    private

    def process_title(title)
      title.gsub(/,:/, "")
    end
  end
end

class FilmaffinityAdaptor
  class << self
    require "filmaffinity"

    def import_ratings(user_id, fa_user_id)
      ratings = Filmaffinity.get_user_ratings(fa_user_id)

      process_ratings(user_id, ratings)
    end

    def process_ratings(user_id, ratings)
      ratings.each do |rating|
        process_rating(user_id, rating)
      end
    end

    def process_rating(user_id, fa_rating)
      @movies = Movie.standard_search(process_title(fa_rating[:title])).results
      
      if @movies.empty?
        create_import(user_id, false, "No movies returned", nil, fa_rating)
      else
        movie = @movies.detect { |m| m.release_date.try(:year).to_i == fa_rating[:year].to_i } || @movies.detect { |m| m.decorate.directors_names == fa_rating[:director] }

        if movie
          rating = Rating.find_by_user_id_and_movie_id(user_id, movie.id)

          if rating.nil?
            rating = Rating.create(
              user_id: user_id,
              movie_id: movie.id,
              value: fa_rating[:rating]
            )

            msg = "Completed"
          else
            msg = "Existing"
          end

          create_import(user_id, true, msg, rating.id, fa_rating)
        else
          create_import(user_id, false, "Movies returned, but not similar", nil, fa_rating)
        end
      end
    end

    private

    def process_title(title)
      title.gsub(/,:/, "")
    end

    def create_import(user_id, completed, status, rating_id, fa_rating)
      Import.create(
        user_id: user_id,
        completed: completed,
        status: status,
        rating_id: rating_id,
        rated_source: "Filmaffinity",
        rated_title: fa_rating[:title],
        rated_value: fa_rating[:rating],
        rated_year: fa_rating[:year],
        rated_director: fa_rating[:director]
      )
    end
  end
end

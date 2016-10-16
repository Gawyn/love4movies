class Filmaffinity
  class << self
    require 'json'
    require 'nokogiri'
    require 'open-uri'

    USER_RATING_URL = "http://www.filmaffinity.com/en/userratings.php?orderby=8"

    def write_user_ratings(user_id)
      ratings = get_user_ratings(user_id)

      File.open("my-fa-ratings.json", "w") do |f|
        f.write(ratings.to_json)
      end
    end

    def get_user_ratings(user_id)
      url = USER_RATING_URL + "&user_id=#{user_id}"
      doc = Nokogiri::HTML(open(url))
      total_pages = doc.search(".pager a")[-2].text.to_i

      (1..total_pages).map do |page|
        get_page(user_id, page)
      end.flatten
    end

    def get_page(user_id, page)
      url = USER_RATING_URL + "&user_id=#{user_id}" + "&p=#{page.to_s}"

      puts "Opening #{url}"
      doc = Nokogiri::HTML(open(url))

      titles = doc.search(".mc-title a").map { |v| v.attr("title") }
      years = doc.search(".mc-title").map { |v| v.children[1].text.gsub("(","").gsub(")","").strip }
      directors = doc.search(".mc-director").map(&:text)
      cast = doc.search(".mc-cast").map { |v| v.text.split(",").map(&:strip) }
      ratings = doc.search(".ur-mr-rat").map(&:text)

      genres = genres_parser(doc)

      (0..(titles.count-1)).map do |i|
        {
          title: titles[i],
          year: years[i],
          director: directors[i],
          cast: cast[i],
          rating: ratings[i],
          genre: genres[i]
        }
      end
    end

    def genres_parser(doc)
      genres = doc.search(".user-ratings-header")

      if genres.count == 1
        genre = genres.first.text.split(" ")[1..-1].join(" ")
        [genre] * doc.search(".user-ratings-movie").count
      else
        wrappers = doc.search(".user-ratings-wrapper")

        wrappers.map do |wrapper|
          movie_count = wrapper.search(".user-ratings-movie").count
          genre = wrapper.search(".user-ratings-header").text.split(" ")[1..-1].join(" ")
          [genre] * movie_count
        end.flatten
      end
    end
  end
end

module Myimdb
  module Scraper
    class RottenTomatoes < Scraper::Base
      def initialize(url)
        @url = url
      end

      def rating
        document.css(".critic_stats span")[0].inner_text.to_f
      end

      def votes
        document.css(".critic_stats span")[1].text.to_i
      end

      def genres
        document.css("span.label:contains('Genre:') + span.content span").collect{ |a| a.text }
      end

      def plot
        document.css("#movie_synopsis_all").inner_text.strip
      end
      
      def image
        document.css(".movie_poster_area a img").first['src']
      end

      private
        def document
          @document ||= Nokogiri::HTML(open(@url))
        end

        handle_exceptions_for :rating, :votes, :genres, :plot, :image
    end
  end
end
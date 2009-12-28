module Myimdb
  module Scraper
    class RottenTomatoes < Scraper::Base
      def initialize(url)
        @url = url
      end

      def rating
        document.search("#tomatometer_data p:nth-child(4) span").inner_text.strip.to_i rescue nil
      end
    
      def votes
        document.search("#tomatometer_data p:nth-child(1) span").inner_text.strip.to_i rescue nil
      end
    
      def genres
        document.search("#movie_stats .fl:first p:last .content a").inner_text.scraper_unescape_html.to_a rescue []
      end
    
      def plot
        document.search("#movie_synopsis_all").inner_text.strip rescue nil
      end
    
      private
        def document
          @document ||= Hpricot(open(@url))
        end
    end
  end
end
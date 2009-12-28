module Myimdb
  module Scraper
    class RottenTomatoes < Scraper::Base
      def initialize(url)
        @url = url
      end

      def rating
        document.css("#tomatometer_data p:nth-child(4) span").inner_text.strip.to_i rescue nil
      end
    
      def votes
        document.css("#tomatometer_data p:nth-child(1) span").inner_text.strip.to_i rescue nil
      end
    
      def genres
        document.css("#movie_stats .fl:first p:last .content a").inner_text.scraper_unescape_html.to_a rescue []
      end
    
      def plot
        document.css("#movie_synopsis_all").inner_text.strip rescue nil
      end
    
      private
        def document
          @document ||= Nokogiri::HTML(open(@url))
        end
    end
  end
end
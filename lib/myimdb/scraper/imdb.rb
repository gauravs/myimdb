module Myimdb
  module Scraper
    class Imdb < Scraper::Base
      def initialize(url)
        @url = url
      end
    
      def directors
        document.css('.info h5:contains("Director") + .info-content a:not(.tn15more)').collect{ |a| a.text } rescue []
      end
    
      def writers
        document.css('.info h5:contains("Writer") + .info-content a:not(.tn15more)').collect{ |a| a.text } rescue []
      end
    
      def rating
        document.css(".general.rating b").inner_text.strip.split('/').first.to_f
      end
    
      def votes
        document.css(".general.rating a").inner_text.strip.sub(',', '').to_i rescue nil
      end
    
      def genres
        document.css('.info h5:contains("Genre:") + .info-content a:not(.tn15more)').collect{ |a| a.text } rescue []
      end
    
      def tagline
        document.css('.info h5:contains("Tagline:") + .info-content').children[0].text.strip rescue nil
      end
    
      def plot
        document.css('.info h5:contains("Plot:") + .info-content').children[0].text.strip rescue nil
      end
    
      def year
        document.css("div#tn15title a:first")[0].text.to_i
      end
    
      private
        def document
          @document ||= Nokogiri::HTML(open(@url))
        end
    end
  end
end
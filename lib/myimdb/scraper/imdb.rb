module Myimdb
  module Scraper
    class Imdb < Scraper::Base
      def initialize(url)
        @url = url
      end

      def directors
        document.css('.info h5:contains("Director") + .info-content a:not(.tn15more)').collect{ |a| a.text }
      end

      def directors_with_url
        document.css('.info h5:contains("Director") + .info-content a:not(.tn15more)').collect{ |a| {:name=> a.text, :url=> "http://www.imdb.com#{a['href']}" } }
      end

      def writers
        document.css('.info h5:contains("Writer") + .info-content a:not(.tn15more)').collect{ |a| a.text }
      end

      def writers_with_url
        document.css('.info h5:contains("Writer") + .info-content a:not(.tn15more)').collect{ |a| {:name=> a.text, :url=> "http://www.imdb.com#{a['href']}" } }
      end

      def rating
        document.css(".starbar-meta b").inner_text.strip.split('/').first.to_f
      end

      def votes
        document.css(".starbar-meta a").inner_text.strip.split(' ').first.sub(',', '').to_i
      end

      def genres
        document.css('.info h5:contains("Genre:") + .info-content a:not(.tn15more)').collect{ |a| a.text }
      end

      def tagline
        document.css('.info h5:contains("Tagline:") + .info-content').children[0].text.strip rescue nil
      end

      def plot
        document.css('.info h5:contains("Plot:") + .info-content').children[0].text.strip
      end

      def year
        document.css("div#tn15title a:first")[0].text.to_i
      end

      def release_date
        Date.parse(document.css('.info h5:contains("Release Date:") + .info-content').inner_text)
      end

      def image
        image_url = document.css(".photo:first a").first['href']
        unless image_url.nil? or image_url =~ /addposter/
          image_document = Nokogiri::HTML(open("http://www.imdb.com#{image_url}"))
          image_document.css('#principal img:first').first['src']
        end
      end

      private
        def document
          @document ||= Nokogiri::HTML(open(@url))
        end

        handle_exceptions_for :directors, :directors_with_url, :writers, :writers_with_url, :rating, :votes, :genres, :tagline, :plot, :year, :image
    end
  end
end
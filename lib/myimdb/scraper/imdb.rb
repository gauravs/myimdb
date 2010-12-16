module Myimdb
  module Scraper
    class Imdb < Scraper::Base
      def initialize(url)
        @url = url
      end

      def directors
        document.css('#overview-top .txt-block h4:contains("Director") ~ a:not(:contains(" more "))').collect{ |a| a.text }
      end

      def directors_with_url
        document.css('#overview-top .txt-block h4:contains("Director") ~ a:not(:contains(" more "))').collect{ |a| {:name=> a.text, :url=> "http://www.imdb.com#{a['href']}" } }
      end

      def writers
        document.css('#overview-top .txt-block h4:contains("Writer") ~ a:not(:contains(" more "))').collect{ |a| a.text }
      end

      def writers_with_url
        document.css('#overview-top .txt-block h4:contains("Writer") ~ a:not(:contains(" more "))').collect{ |a| {:name=> a.text, :url=> "http://www.imdb.com#{a['href']}" } }
      end

      def rating
        document.css(".star-box .rating-rating").inner_text.strip.split('/').first.to_f
      end

      def votes
        document.css(".star-box a[href='ratings']").inner_text.strip.split(' ').first.sub(',', '').to_i
      end

      def genres
        document.css('.see-more.inline.canwrap h4:contains("Genres:") ~ a:not(:contains(" more "))').collect{ |a| a.text }
      end

      def tagline
        strip_useless_chars(document.css('.txt-block h4:contains("Taglines:")').first.parent.inner_text).gsub(/Taglines |See more/, '') rescue nil
      end

      def plot
        strip_useless_chars(document.css('.article h2:contains("Storyline") ~ p').inner_text).gsub(/Written by.*/, '')
      end

      def year
        release_date.year
      end

      def release_date
        Date.parse(document.css("a[title='See all release dates']").inner_text)
      end

      def image
        document.css('#img_primary img').first['src']
      end

      private
        def document
          @document ||= Nokogiri::HTML(open(@url))
        end

        handle_exceptions_for :directors, :directors_with_url, :writers, :writers_with_url, :rating, :votes, :genres, :tagline, :plot, :year, :image
    end
  end
end
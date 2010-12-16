module Myimdb
  module Scraper
    class Metacritic < Scraper::Base
      def initialize(url)
        @url = url
      end

      def rating
        document.css(".score_value").first.inner_text.strip.to_f/10
      end

      def votes
        document.css(".summary .count a:contains('Critics')").inner_text.strip.to_i
      end

      def genres
        document.css(".summary_detail.product_genre span.data").inner_text.gsub(/\s/, '').split(',')
      end

      def plot
        document.css(".summary_detail.product_summary .inline_expand_collapse.inline_collapsed span.blurb").inner_text.strip
      end
      
      def image
        document.css("img.product_image.large_image").first['src']
      end

      private
        def document
          @document ||= Nokogiri::HTML(open(@url))
        end

        handle_exceptions_for :rating, :votes, :genres, :plot
    end
  end
end
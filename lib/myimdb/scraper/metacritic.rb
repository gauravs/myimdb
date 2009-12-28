module Myimdb
  module Scraper
    class Metacritic < Scraper::Base
      def initialize(url)
        @url = url
      end
    
      def rating
        document.css("#metascore").inner_text.strip.to_f/10 rescue nil
      end
    
      def votes
        document.at("a[@href='#critics']").inner_text.strip.to_i rescue nil
      end
    
      def genres
        document.css("#productinfo p:first").text.gsub(/^\S+:/, '').split("|").map(&:strip_useless_chars) rescue []
      end
    
      def plot
        document.css("#productsummary .summarytext").inner_text.strip rescue nil
      end
    
      private
        def document
          @document ||= Nokogiri::HTML(open(@url))
        end
    end
  end
end
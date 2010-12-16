module Myimdb
  module Scraper
    class Freebase < Scraper::Base
      include HTTParty
      format  :json
      headers 'Content-Type' => 'application/json'

      def initialize(url)
        @key = url.gsub(/.*?\/view/, '')
        @url = "http://www.freebase.com/experimental/topic/standard?id=#{@key}"
      end

      def directors
        parse_text '/film/film/directed_by'
      end

      def directors_with_url
        parse_text_and_url '/film/film/directed_by'
      end

      def writers
        parse_text '/film/film/written_by'
      end

      def writers_with_url
        parse_text_and_url '/film/film/written_by'
      end

      def genres
        parse_text '/film/film/genre'
      end

      def tagline
        parse_text('/film/film/tagline')[0]
      end

      def plot
        document['description']
      end

      def year
        release_date.year
      end

      def release_date
        Date.parse(parse_text('/film/film/initial_release_date')[0])
      end

      def image
        document['thumbnail']
      end
      
      private
        def document
          @document ||= begin
            result = self.class.get( @url )[@key]
            unless result['code'].index("ok")
              raise DocumentNotFound.new("Unable to locate freebase article")
            end
            result['result']
          end
        end

        def parse_text(path)
          document['properties'][path]['values'].collect{ |obj| obj['text'] }
        end

        def parse_text_and_url(path)
          document['properties'][path]['values'].collect{ |obj| { :name=> obj['text'], :url=> obj['url'] } }
        end
        
        handle_exceptions_for :directors, :directors_with_url, :writers, :writers_with_url, :genres, :tagline, :plot, :year, :image, :release_date
    end
  end
end
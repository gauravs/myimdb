module Myimdb
  module Search
    class Bing < Base
      include HTTParty
      format  :json
      headers 'Content-Type' => 'application/json'
      
      AppKey = '36C1CEF363A00C6536C4420D356B5E507C4C2AF1'
      base_uri  'api.search.live.net'
      
      class << self
        def search_text( text, options={} )
          text = text + " site:#{options[:restrict_to]}" if !options[:restrict_to].blank?
          response = get( '/json.aspx', :query=> {:Appid=> AppKey, :query=> text, :sources=> 'web'} )
          parse_search_result(response, 'Web')
        end
        
        def search_images( text, options={} )
          text = text + " site:#{options[:restrict_to]}" if !options[:restrict_to].blank?
          response = get( '/json.aspx', :query=> {:Appid=> AppKey, :query=> text, :sources=> 'image'} )
          parse_search_result(response, 'Image')
        end
        
        def spell( text, options={} )
          text = text + " site:#{options[:restrict_to]}" if !options[:restrict_to].blank?
          response = get( '/json.aspx', :query=> {:Appid=> AppKey, :query=> text, :sources=> 'spell'} )
          parse_search_result(response, 'Spell')
        end
        
        private
          def parse_search_result( response, type )
            response['SearchResponse'][type]['Results'].collect do |response_element|
              {
                :url    => response_element['Url'],
                :title  => response_element['Title']
              }
            end
          end
      end
    end
  end
end
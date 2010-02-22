module Myimdb
  module Search
    class Google < Base
      include HTTParty
      format  :json
      headers 'Content-Type' => 'application/json'

      base_uri  'ajax.googleapis.com'
      
      class << self
        def search_text( text, options={} )
          text = text + " site:#{options[:restrict_to]}" if !options[:restrict_to].blank?
          response = get( '/ajax/services/search/web', :query=> {:v=> '1.0', :q=> text} )
          parse_search_result( response )
        end

        def search_images( text, options={} )
          sizes = {
            'large'   => 'l',
            'medium'  => 'm',
            'small'   => 'i'
          }
          search_options = { :v=> '1.0', :q=> text }
          search_options.merge!(:imgsz=> sizes[options[:size].to_s]) if !options[:size].blank?
          text = text + " site:#{options[:restrict_to]}" if !options[:restrict_to].blank?
          response = get( '/ajax/services/search/images', :query=> search_options )
          parse_search_result( response )
        end
        
        private
          def parse_search_result( response )
            response['responseData'] and response['responseData']['results'].collect do |response_element|
              {
                :url    => response_element['url'],
                :title  => response_element['titleNoFormatting']
              }
            end
          end
      end
    end
  end
end
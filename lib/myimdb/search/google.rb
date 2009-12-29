module Myimdb
  module Search
    class Google
      include HTTParty

      format    :json
      headers   'Content-Type' => 'application/json' 
      base_uri  'ajax.googleapis.com'
    
      def self.search_text( text, options={} )
        text = text + " site:#{options[:restrict_to]}" if !options[:restrict_to].blank?
        response = get( '/ajax/services/search/web', :query=> {:v=> '1.0', :q=> text} )
        response['responseData'] and response['responseData']['results']
      end
    end
  end
end
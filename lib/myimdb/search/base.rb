module Myimdb
  module Search
    class Base
      class << self
        def spell_movie( text, options={} )
          search_results = search_text(text, :restrict_to=> 'imdb.com')
          search_results and search_results.collect do |search_result|
            search_result[:title].gsub(/ \(.*$/, "")
          end
        end
      end
    end
  end
end
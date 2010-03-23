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

        def search( text, options )
          engines = [Myimdb::Search::Google, Myimdb::Search::Bing]

          def _search(engine, text, options)
            engine.search_text(text, options)
          end

          engines.each do |engine|
            puts "Retrying using #{engine}" unless engines.index(engine) == 0
            result = _search(engine, text, options)
            return result unless result.nil? or result.empty?
          end
        end
      end
    end
  end
end
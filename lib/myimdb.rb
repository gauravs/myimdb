require 'rubygems'
require 'httparty'
require 'nokogiri'
require 'open-uri'

require 'myimdb/search'
require 'myimdb/scraper'

class ImdbMovie
  def self.search(movie_name)
    search_result = Myimdb::Search::Google.search_text(movie_name, :restrict_to=> 'imdb.com')[0]
    Myimdb::Scraper::Imdb.new(search_result[:url]) if search_result
  end
end
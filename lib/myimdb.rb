require "rubygems"
require "httparty"
require "nokogiri"
require "open-uri"

require "#{File.dirname(__FILE__)}/myimdb/search"
require "#{File.dirname(__FILE__)}/myimdb/scraper"

class ImdbMovie
  def self.search(movie_name)
    search_result = Myimdb::Search::Base.search(movie_name, :restrict_to=> "imdb.com")[0]
    Myimdb::Scraper::Imdb.new(search_result[:url]) if search_result
  end
end

class String
  def blank?
    self.nil? || self.size == 0
  end
end
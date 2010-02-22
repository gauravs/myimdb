require 'cgi'
require 'iconv'

module Myimdb
  module Scraper
    module StringExtensions
      def scraper_unescape_html(string)
        Iconv.conv("UTF-8", 'ISO-8859-1', CGI::unescapeHTML(string))
      end

      def strip_useless_chars(string)
        string.gsub(/[^a-zA-z0-9\|\-_\(\)@$\/\\]/, '')
      end
    end
  end
end
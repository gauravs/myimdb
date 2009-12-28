require 'cgi'
require 'iconv'

module Myimdb
  module Scraper
    module StringExtensions
      def scraper_unescape_html
        Iconv.conv("UTF-8", 'ISO-8859-1', CGI::unescapeHTML(self))
      end

      def scraper_strip_tags
        gsub(/<\/?[^>]*>/, "")
      end
    
      def strip_useless_chars
        gsub(/[^a-zA-z0-9\|\-_\(\)@$\/\\]/, '')
      end
    end
  end
end

String.send :include, Myimdb::Scraper::StringExtensions
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
      
      def titleize
        humanize.gsub(/\b('?[a-z])/) { $1.capitalize }
      end
      
      def humanize
        gsub(/_/, " ").capitalize
      end
      
      def constantize
        names = self.split('::')
        names.shift if names.empty? || names.first.empty?
      
        constant = Object
        names.each do |name|
          constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
        end
        constant
      end
    end
  end
end

String.send :include, Myimdb::Scraper::StringExtensions
class UnformattedHtml < Exception; end

module HandleExceptions
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.send(:extend, ClassMethods)
  end
  
  module InstanceMethods
  end
  
  module ClassMethods
    def handle_exceptions_for(*method_names)
      method_names.each do |method_name|
        alias_method("_#{method_name}", method_name)
        define_method(method_name) do
          begin
            send("_#{method_name}")
          rescue
            raise UnformattedHtml.new("Unable to find tag: #{method_name}, probably you are parsing the wrong page.")
          end
        end
      end
    end
  end
end

module Myimdb
  module Scraper
    class Base
      include HandleExceptions
      def directors
      end
    
      def writers
      end
    
      def rating
      end
    
      def votes
      end
    
      def genres
      end
    
      def tagline
      end
    
      def plot
      end
    
      def year
      end
      
      def release_date
      end
      
      def summary
        [:directors, :writers, :rating, :votes, :genres, :tagline, :plot, :year, :release_date].collect do |meth|
          data = send(meth)
          data = data.join(", ") if Array === data
          sprintf("%-15s : %s", meth.to_s.titleize, data)
        end.join("\n")
      end

    end
  end
end
#require './nbp/version'

require 'net/http'
require 'uri'
require 'date'
require 'pry'

# pobiera wyłącznie tablicę a - kursy walut obcych

module Exchanges
  module Rates
    module Nbp
      NBP_URL = 'http://www.nbp.pl/kursy/xml/'

      @@date = Date.today

      def date
        @@date
      end

      def date=(at_date)
        @@date = at_date
      end

      def self.get_filename
        # according to: http://www.nbp.pl/home.aspx?f=/kursy/instrukcja_pobierania_kursow_walut.html
        index = Net::HTTP.get(URI.parse('http://www.nbp.pl/kursy/xml/dir.txt'))
        index[/(a[0-9][0-9][0-9]z#{@@date.strftime("%y%m%d")}+)/, 1]
      end
    end
  end
end

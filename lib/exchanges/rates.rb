require 'net/http'
require 'uri'
require 'date'
require 'open-uri'
require 'nokogiri'

module Exchanges
  module Rates
    NBP = 'http://www.nbp.pl/kursy/xml/'

    @@date = Date.today

    def self.date
      @@date
    end

    def self.date=(at_date)
      @@date = at_date
    end

    def self.codes
      self.xml.xpath("//pozycja/kod_waluty/text()").map {|c| c.to_s }
    end

    def self.rates(currency)
      rate = {}
      rate[:symbol] = xml.xpath("//pozycja[kod_waluty='#{currency}']/kod_waluty/text()").to_s
      rate[:name] = xml.xpath("//pozycja[kod_waluty='#{currency}']/nazwa_waluty/text()").to_s
      rate[:base] = xml.xpath("//pozycja[kod_waluty='#{currency}']/przelicznik/text()").to_s
      rate[:average_rate] = xml.xpath("//pozycja[kod_waluty='#{currency}']/kurs_sredni/text()").to_s.gsub(',', '.').to_f
      rate
    end

    def self.published_at
      Date.parse(xml.xpath("//tabela_kursow/data_publikacji/text()").to_s)
    end

    private
    def self.filename
      # according to: http://www.nbp.pl/home.aspx?f=/kursy/instrukcja_pobierania_kursow_walut.html
      index = Net::HTTP.get(URI.parse(NBP + 'dir.txt'))

      while index[/(a[0-9][0-9][0-9]z#{@@date.strftime("%y%m%d")}+)/, 1].nil? do
        @@date -= 1
      end
      index[/(a[0-9][0-9][0-9]z#{@@date.strftime("%y%m%d")}+)/, 1]
    end

    def self.url 
      File.join(NBP, self.filename + '.xml') if self.filename
    end

    def self.xml
      begin
        doc = open(self.url)
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end

      Nokogiri::HTML(doc) if doc
    end
  end
end

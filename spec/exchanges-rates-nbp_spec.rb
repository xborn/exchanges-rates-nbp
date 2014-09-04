require 'spec_helper'

RSpec.describe Exchanges::Parsing do
  before(:each) do
  	Exchanges::Parsing.date = Date.today
  end

  describe 'constant NBP' do	
	  it 'responds to constant NBP' do
	    expect(Exchanges::Parsing::NBP).to be
	  end
	  it 'NBP is url' do
	    expect(Exchanges::Parsing::NBP.match(/^http:\/\//)).to be_truthy
	  end
	end

  describe '@@date' do  	
	  it 'module responds to @@date' do
	  	expect(Exchanges::Parsing.date).to be
	  end
	  it 'default @@date is today' do
	    expect(Exchanges::Parsing.date).to eq Date.today
	  end
	  it 'is possible to change @@date' do
	  	Exchanges::Parsing.date = Date.today - 3
	  	expect(Exchanges::Parsing.date).to eq Date.today - 3
	  end
	end

  it 'returns url to xml file' do
  	expect(Exchanges::Parsing.url.match(/.xml$/)).to be_truthy
  end

  describe '.filename' do
    it 'returns filename \'a167z140829\' for Sunday, 2014-08-31\'' do
      Exchanges::Parsing.date = Date.new(2014,8,31)
      expect(Exchanges::Parsing.filename).to eq 'a167z140829'
    end
    it 'returns filename \'a167z140829\' for Friday, 2014-08-29\'' do
      Exchanges::Parsing.date = Date.new(2014,8,31)
      expect(Exchanges::Parsing.filename).to eq 'a167z140829'
    end
  end

  describe '.xml' do
    it 'returns xml for chosen date' do
    	xml = Exchanges::Parsing.xml
      expect(xml.xpath("//data_publikacji/text()").to_s).to eq Exchanges::Parsing.date.strftime("%Y-%m-%d")
    end
  end

  describe '.currency_codes' do
    it 'returns array' do
      expect(Exchanges::Parsing.currency_codes).to be_kind_of(Array)      
    end
  end

  describe '.currency_info' do
  	it 'returns Hash contained necessary informations' do
      expect(Exchanges::Parsing.currency_info('USD')).to be_kind_of(Hash)
  	end
  	it 'Hash contains keys :symbol, :name, :base, :average_rate' do
  		expect(Exchanges::Parsing.currency_info('USD').keys.sort).to eq [:average_rate, :base, :name, :symbol]
    end
  end
end
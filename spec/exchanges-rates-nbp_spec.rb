require 'spec_helper'

RSpec.describe Exchanges::Rates do

  context 'when date is default' do
    before(:each) do
      Exchanges::Rates.date = Date.today
    end

    describe 'constant NBP' do
      it 'responds to constant NBP' do
        expect(Exchanges::Rates::NBP).to be
      end
      it 'NBP is url' do
        expect(Exchanges::Rates::NBP.match(/^http:\/\//)).to be_truthy
      end
    end

    describe '@@date' do
      it 'module responds to @@date' do
        expect(Exchanges::Rates.date).to be
      end
      it 'default @@date is today' do
        expect(Exchanges::Rates.date).to eq Date.today
      end
      it 'is possible to change @@date' do
        Exchanges::Rates.date = Date.today - 3
        expect(Exchanges::Rates.date).to eq Date.today - 3
      end
    end

    it 'returns url to xml file' do
      expect(Exchanges::Rates.url.match(/.xml$/)).to be_truthy
    end

    describe '.xml' do
      it 'returns xml for chosen date' do
        xml = Exchanges::Rates.xml
        expect(xml.xpath("//data_publikacji/text()").to_s).to eq Exchanges::Rates.date.strftime("%Y-%m-%d")
      end
    end

    describe '.codes' do
      it 'returns array' do
        expect(Exchanges::Rates.codes).to be_kind_of(Array)
      end
    end

    describe '.rates' do
      it 'returns Hash contained necessary informations' do
        expect(Exchanges::Rates.rates('USD')).to be_kind_of(Hash)
      end
      it 'Hash contains keys :symbol, :name, :base, :average_rate' do
        expect(Exchanges::Rates.rates('USD').keys.sort).to eq [:average_rate, :base, :name, :symbol]
      end
      it 'rate is a Float' do
        expect(Exchanges::Rates.rates('USD')[:average_rate]).to be_kind_of(Float)
      end
      it 'symbol, name, base and rate are not empty' do
        [:symbol, :name, :base, :average_rate].each do |k|
          expect(Exchanges::Rates.rates('USD')[k].to_s).not_to be_empty
        end
      end
    end

    describe '.published_at' do
      it 'returns Date' do
        expect(Exchanges::Rates.published_at).to be_kind_of(Date)
      end
    end

  end

  context 'when date is weekend day \'2014-08-31\', Sunday' do
    before(:each) do
      Exchanges::Rates.date = Date.new(2014,8,31)
    end

    describe '.filename' do
      it 'returns filename \'a167z140829\' for Sunday, 2014-08-31\'' do
        expect(Exchanges::Rates.filename).to eq 'a167z140829'
      end
      it 'returns filename \'a167z140829\' for Friday, 2014-08-29\'' do
        expect(Exchanges::Rates.filename).to eq 'a167z140829'
      end
    end

    describe '.rates' do
      it 'at \'2014-08-31\' USD rate is 3.1965 (from table at \'2014-08-29\')' do
        expect(Exchanges::Rates.rates('USD')[:average_rate]).to eq 3.1965
      end
    end
  end

end
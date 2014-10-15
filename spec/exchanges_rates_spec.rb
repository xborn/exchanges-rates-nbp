require 'spec_helper'

class DummyClass
  include Exchanges::Rates

  def initialize(date, args)
    @date = date ||= Date.today
    @selected_currencies = args.nil? ? [] : args[:selected_currencies]
  end
end

RSpec.describe Exchanges::Rates do
  include Exchanges::Rates

  context 'when date is default' do
    before(:each) do
      @dummy = DummyClass.new(Date.today, nil)
    end

    describe 'constant NBP' do
      it 'responds to constant NBP' do
        expect(Exchanges::Rates::NBP).to be
      end
      it 'NBP is url' do
        expect(Exchanges::Rates::NBP.match(/^http:\/\//)).to be_truthy
      end
    end

    describe '@date' do
      it 'module responds to @@date' do
        expect(@dummy.date).to be
      end
      it 'default @date is today' do
        expect(@dummy.date).to eq Date.today
      end
      it 'is possible to change @date' do
        @dummy.date = Date.today - 3
        expect(@dummy.date).to eq Date.today - 3
      end
    end

    it 'returns url to xml file' do
      expect(@dummy.url.match(/.xml$/)).to be_truthy
    end

    describe '#xml' do
      it 'returns xml for chosen date' do
        xml = @dummy.xml
        expect(xml.xpath("//data_publikacji/text()").to_s).to eq @dummy.date.strftime("%Y-%m-%d")
      end
    end

    describe '#codes' do
      it 'returns array' do
        expect(@dummy.codes).to be_kind_of(Array)
      end
    end

    describe '#rates' do
      it 'returns Hash contained necessary informations' do
        expect(@dummy.rates('USD')).to be_kind_of(Hash)
      end
      it 'Hash contains keys :symbol, :name, :base, :average_rate' do
        expect(@dummy.rates('USD').keys.sort).to eq [:average_rate, :base, :name, :symbol]
      end
      it 'base is a Float' do
        expect(@dummy.rates('USD')[:base]).to be_kind_of(Float)
      end
      it 'rate is a Float' do
        expect(@dummy.rates('USD')[:average_rate]).to be_kind_of(Float)
      end
      it 'symbol, name, base and rate are not empty' do
        [:symbol, :name, :base, :average_rate].each do |k|
          expect(@dummy.rates('USD')[k].to_s).not_to be_empty
        end
      end
    end

    describe '#published_at' do
      it 'returns Date' do
        expect(@dummy.published_at).to be_kind_of(Date)
      end
    end

  end

  context 'when date is weekend day \'2014-08-31\', Sunday' do
    before(:each) do
      @dummy = DummyClass.new(Date.new(2014, 8, 31), nil)
    end

    describe '#filename' do
      it 'returns \'a167z140829\' for Sunday, 2014-08-31\'' do
        expect(@dummy.filename).to eq 'a167z140829'
      end
      it 'returns \'a167z140829\' for Friday, 2014-08-29\'' do
        expect(@dummy.filename).to eq 'a167z140829'
      end
    end

    describe '#rates' do
      it 'at \'2014-08-31\' USD rate is 3.1965 (from table at \'2014-08-29\')' do
        expect(@dummy.rates('USD')[:average_rate]).to eq 3.1965
      end
    end
  end

  context 'when only \'USD\' is selected' do
    before(:each) do
      @dummy = DummyClass.new(Date.new(2014, 8, 31), {selected_currencies: ['USD']})
    end

    describe '#codes' do
      it 'returns only one code' do
        expect(@dummy.codes.length).to eq 1
      end  
    end
  end

  context 'when only \'USD\', \'EUR\' and \'GBP\' are selected' do
    before(:each) do
      @dummy = DummyClass.new(Date.new(2014, 8, 31), {selected_currencies: ['USD', 'EUR', 'GBP']})
    end

    describe '#codes' do
      it 'returns three codes' do
        expect(@dummy.codes.length).to eq 3
      end  
    end
  end 

  context 'when wrong code is selected' do
    before(:each) do
      @dummy = DummyClass.new(Date.new(2014, 8, 31), {selected_currencies: ['XXX']})
    end

    describe '#codes' do
      it 'returns three codes' do
        expect(@dummy.codes.length).to eq 0
      end  
    end
  end  

end
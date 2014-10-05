require 'spec_helper'

RSpec.describe Exchanges::Import do

  before(:all) do
    @dummy = Exchanges::Import.new(nil, nil)
  end

  context 'when date is not passed' do
    it 'returns @date equal Date.today' do
      expect(@dummy.date).to eq Date.today
    end
  end

  context 'when date is passed e.g. \'2014-08-31\'' do
    before(:all) do
      @dummy = Exchanges::Import.new(Date.new(2014,8,31), nil)
    end

    it 'returns @date equal Date.today' do
      expect(@dummy.date).to eq Date.new(2014,8,31)
    end
  end

  context 'when two valid currencies are chosen' do
    before(:all) do
      @dummy = Exchanges::Import.new(nil, {selected_currencies: ['USD','EUR']})
    end

    it '#codes returns 2-elements Array' do
      expect(@dummy.codes).to be_kind_of(Array)
      expect(@dummy.codes.length).to eq 2
    end
  end

  context 'when any currencies are selected at \'2014-08-31\'' do
    before(:all) do
      @dummy = Exchanges::Import.new(nil, nil)
    end

    it '#codes returns 36-elements Array' do
      expect(@dummy.codes.length).to eq 36
    end
  end  

end
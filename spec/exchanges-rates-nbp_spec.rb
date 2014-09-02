require 'spec_helper'

RSpec.describe Exchanges::Rates::Nbp do
  it 'responds to constant NBP_URL' do
    expect(Exchanges::Rates::Nbp::NBP_URL).to be
  end
end
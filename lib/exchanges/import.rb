module Exchanges
  class Import
    include Exchanges::Rates

    def initialize(date, args)
      @date = date ||= Date.today
      @selected_currencies = args.nil? ? [] : args[:selected_currencies]
    end

  end
end
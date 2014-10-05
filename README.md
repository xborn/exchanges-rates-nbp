# Exchanges::Rates::Nbp

Simple gem that gets exchange rates from the Polish National Bank.

## Installation

Add this line to your application's Gemfile:

    gem 'exchanges-rates-nbp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exchanges-rates-nbp

## Usage

Default usage:

		nbp = Exchange::Nbp.new(nil, nil)

,parameters:

* date - default Date.today, you can pass another valid date

* args - optional parameters 


Class instance has three important methods:

* codes - returns currency symbols from table,

* published_at - returns publication date exchange rates,

* rates(currency) - returns currency rate at indicated date


If you interested only selected currencies at indicated day use in this way:

		nbp = Exchange::Nbp.new(Date.today - 3, {selected_currencies: ['USD', 'EUR']})


Now you can retrieve currency rates for chosen:

    nbp.codes.each do |c|
      nbp.rates(c)
    end


## Future ideas
1. Currency and CurrencyRate model, Sequel/ActiveRecord migration
2. Background job to retrieve currency rates automatically


## Contributing

1. Fork it ( https://github.com/[my-github-username]/exchanges-rates-nbp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

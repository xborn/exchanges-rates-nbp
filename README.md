# Exchanges::Rates::Nbp

Simple gem that gets exchange rates from the Polish National Bank.

## Installation

Add this line to your application's Gemfile:
----------
```bash
    gem 'exchanges-rates-nbp'
```
And then execute:
```bash
    $ bundle
```
Or install it yourself as:
```bash
    $ gem install exchanges-rates-nbp
```
## Usage

Basic usage:
```ruby
		nbp = Exchanges::Nbp.new(nil, nil)
```
parameters:
* date - default Date.today, you can pass another valid date
* args - optional parameters, currently only one `selected_currencies`, example below


Class instance has three important methods
* `codes` - returns currency symbols from table,
* `published_at` - returns publication date exchange rates,
* `rates(currency)` - returns currency rate at indicated date

To get all codes from table call it:
```ruby
		nbp.codes #=> ["THB", "USD", "AUD", "HKD", "CAD", "NZD", "SGD", "EUR", "HUF", "CHF", "GBP", "UAH", "JPY", "CZK", "DKK", "ISK", "NOK", "SEK", "HRK", "RON", "BGN", "TRY", "LTL", "ILS", "CLP", "PHP", "MXN", "ZAR", "BRL", "MYR", "RUB", "IDR", "INR", "KRW", "CNY", "XDR"]
```

To get exchange rate e.g. USD you have to call:
```ruby
		nbp.rates("USD") #=> {:symbol=>"USD", :name=>"dolar amerykański", :base=>1.0, :average_rate=>3.2964}
```

If you interested only selected currencies at indicated day use in this way:
```ruby
		nbp = Exchanges::Nbp.new(Date.today - 3, {selected_currencies: ['USD', 'EUR']})
```

Now you can retrieve currency rates for chosen:
```ruby
    nbp.codes.each do |c|
      nbp.rates(c)
    end
```

## Future ideas
1. Currency and CurrencyRate model, Sequel/ActiveRecord migration
2. Background job to retrieve currency rates automatically


## Contributing

1. Fork it ( https://github.com/[my-github-username]/exchanges-rates-nbp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## License
Copyright(c) 2014 Krzysztof Wiesławski, released under the MIT license
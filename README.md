# Series
[![Build Status](https://travis-ci.org/pducks32/series.svg)](https://travis-ci.org/pducks32/series)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'series'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install series

## Usage

```ruby
require "series"

series = Series.new { |n| Rational(1, 2 * n) }
series[1] #=> (1/2)
series[2] #=> (1/4)
series.partial_sum(5) #=> (137/120)

# You can even provide an upper bound
series = Series.new(upper_bound: 3) { |n| Rational(1, 2 * n) }
series[1] #=> (1/2)
series[2] #=> (1/4)
# Although you can still evaluate the expression at any `n` solving will halt at the bound
series[4] #=> (1/16)
series.first(8) #=> [ (1/2), (1/4), (1/9)]
series.partial_sum(5) #=> (137/120)

# Lower bounds work too!
series = Series.new(lower_bound: 3) { |n| Rational(1, 2 * n) }
series.first #=> (1/9)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pducks32/series.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

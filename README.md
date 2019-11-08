# activemodel-csv_validator

CSV Validator for Active Model

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activemodel-csv_validator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activemodel-csv_validator

## Usage

```ruby
class CsvForm
  include ActiveModel::Model

  attr_accessor :file

  validates :file, presence: true, csv: { max: 100, headers: %w[field1 field2 field3] }
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aki77/activemodel-csv_validator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

# WalletPay API
Read more info in official documentation: https://docs.wallet.tg/pay/

## Installation
```ruby
gem install 'wallet-pay'
```
```ruby
gem 'wallet-pay'
```

## Configuration
```ruby
WalletPay.configure do |config|
  config.token = token
  config.url = url
  config.api_version = api_version
  config.extra_headers = extra_headers
end

```
or do it with client
```ruby
    WalletPay::Client.new(token: token, url: url, ...)
```

## Usage
### Create new order
```ruby
WalletPay::Client.new.create_order(**order_params)
```
### Preview order
```ruby
WalletPay::Client.new.order_preview(order_id: order_id)
```
### List orders
```ruby
WalletPay::Client.new.orders_list
```
### Get orders amount
```ruby
WalletPay::Client.new.orders_amount
```

### Webhooks
```ruby
Not Implemented
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/wallet-pay. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/RALIST/wallet-pay/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Wallet::Pay project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/wallet-pay/blob/master/CODE_OF_CONDUCT.md).

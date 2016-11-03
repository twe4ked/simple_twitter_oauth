# Simple Twitter OAuth

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'simple_twitter_oauth'
```

## Usage

``` ruby
request_token = SimpleTwitterOAuth.get_request_token(
  consumer_key: 'abc123',
  consumer_secret: 'def456',
  callback_url: 'https://example.com/callback',
)

session[:token] = request_token.token
session[:token_secret] = request_token.secret

redirect_to request_token.authorize_url
```

``` ruby
access_token = SimpleTwitterOAuth.get_access_token(
  consumer_key: 'abc123',
  consumer_secret: 'def456',
  token: session.delete(:token),
  token_secret: session.delete(:token_secret),
  oauth_verifier: params[:oauth_verifier],
)

if access_token
  # These are the methods available on AccessToken:
  #
  #     access_token.screen_name
  #     access_token.token
  #     access_token.secret

  redirect_to account_path, success: 'Account added successfully'
else
  redirect_to account_path, alert: 'Adding account failed'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`,
and then run `bundle exec rake release`,
which will create a git tag for the version,
push git commits and tags,
and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/twe4ked/simple_twitter_oauth This project is intended to be a safe,
welcoming space for collaboration,
and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

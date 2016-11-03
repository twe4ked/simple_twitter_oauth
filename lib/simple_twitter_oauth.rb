require 'simple_twitter_oauth/version'
require 'simple_twitter_oauth/request_token'
require 'simple_twitter_oauth/access_token'

require 'oauth'

module SimpleTwitterOAuth
  SITE = 'https://twitter.com'

  # This method is used to before sending the user to Twitter for authentication.
  #
  # @param consumer_key [String] the Twitter application's consumer key
  # @param consumer_secret [String] the Twitter application's consumer secret
  # @param callback_url [String] the URL that Twitter will call after the user has authenticated
  # @return [SimpleTwitterOAuth::RequestToken] an object with a token, secret, and authorize_url
  def self.get_request_token(consumer_key:, consumer_secret:, callback_url:)
    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, site: SITE)
    request_token = consumer.get_request_token(oauth_callback: callback_url)

    RequestToken.new(
      token: request_token.token,
      secret: request_token.secret,
      authorize_url: request_token.authorize_url(oauth_callback: callback_url),
    )
  end

  # This method is used after the user has authenticated with Twitter.
  #
  # @param consumer_key [String] the Twitter application's consumer key
  # @param consumer_secret [String] the Twitter application's consumer secret
  # @param token [String] the token returned from get_request_token
  # @param token_secret [String] the secret returned from get_request_token
  # @param oauth_verifier [String] the oauth_verifier param from the callback URL
  # @return [SimpleTwitterOAuth::AccessToken, nil] an object with a screen_name, token, and secret, or nil
  def self.get_access_token(consumer_key:, consumer_secret:, token:, token_secret:, oauth_verifier:)
    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, site: SITE)
    request_token = OAuth::RequestToken.from_hash(consumer,
      oauth_token: token,
      oauth_token_secret: token_secret,
    )

    begin
      access_token = request_token.get_access_token(oauth_verifier: oauth_verifier)

      AccessToken.new(
        screen_name: access_token.params[:screen_name],
        token: access_token.token,
        secret: access_token.secret,
      )
    rescue OAuth::Unauthorized
    end
  end
end

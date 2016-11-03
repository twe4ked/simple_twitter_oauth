module SimpleTwitterOAuth
  class RequestToken
    attr_reader :token, :secret, :authorize_url

    # @api private
    def initialize(token:, secret:, authorize_url:)
      @token = token
      @secret = secret
      @authorize_url = authorize_url
      freeze
    end
  end
end

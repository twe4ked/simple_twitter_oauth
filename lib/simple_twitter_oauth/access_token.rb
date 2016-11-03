module SimpleTwitterOAuth
  class AccessToken
    attr_reader :screen_name, :token, :secret

    # @api private
    def initialize(screen_name:, token:, secret:)
      @screen_name = screen_name
      @token = token
      @secret = secret
      freeze
    end
  end
end

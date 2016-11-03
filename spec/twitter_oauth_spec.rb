RSpec.describe SimpleTwitterOAuth, :aggregate_failures do
  let(:oauth_consumer) { double(:oauth_consumer) }

  before do
    allow(OAuth::Consumer).to receive(:new)
      .with('consumer_key', 'consumer_secret', site: 'https://twitter.com')
      .and_return(oauth_consumer)
  end

  describe '.get_request_token' do
    let(:oauth_request_token) { double(:oauth_request_token, token: 'token', secret: 'secret') }

    subject(:get_request_token) do
      SimpleTwitterOAuth.get_request_token(
        consumer_key: 'consumer_key',
        consumer_secret: 'consumer_secret',
        callback_url: 'https://example.com/callback',
      )
    end

    before do
      allow(oauth_consumer).to receive(:get_request_token)
        .with(oauth_callback: 'https://example.com/callback')
        .and_return(oauth_request_token)
      allow(oauth_request_token).to receive(:authorize_url)
        .with(oauth_callback: 'https://example.com/callback')
        .and_return('https://example.com/authorize_url')
    end

    it 'returns a request token' do
      expect(get_request_token).to be_a SimpleTwitterOAuth::RequestToken
      expect(get_request_token.token).to eq 'token'
      expect(get_request_token.secret).to eq 'secret'
      expect(get_request_token.authorize_url).to eq 'https://example.com/authorize_url'
    end
  end

  describe '.get_access_token' do
    let(:oauth_request_token) { double(:oauth_request_token) }
    let(:oauth_access_token) { double(:oauth_access_token, token: 'token', secret: 'secret', params: {screen_name: 'twe4ked'}) }

    subject(:get_access_token) do
      SimpleTwitterOAuth.get_access_token(
        consumer_key: 'consumer_key',
        consumer_secret: 'consumer_secret',
        token: 'request_token',
        token_secret: 'request_secret',
        oauth_verifier: 'oauth_verifier',
      )
    end

    before do
      allow(OAuth::RequestToken).to receive(:from_hash)
        .with(oauth_consumer, oauth_token: 'request_token', oauth_token_secret: 'request_secret')
        .and_return(oauth_request_token)
      allow(oauth_request_token).to receive(:get_access_token)
        .with(oauth_verifier: 'oauth_verifier')
        .and_return(oauth_access_token)
    end

    it 'returns an access token' do
      expect(get_access_token).to be_a SimpleTwitterOAuth::AccessToken
      expect(get_access_token.screen_name).to eq 'twe4ked'
      expect(get_access_token.token).to eq 'token'
      expect(get_access_token.secret).to eq 'secret'
    end

    context 'when unauthorized' do
      before do
        allow(oauth_request_token).to receive(:get_access_token)
          .with(oauth_verifier: 'oauth_verifier')
          .and_raise(OAuth::Unauthorized)
      end

      it 'returns nil' do
        expect(get_access_token).to be_nil
      end
    end
  end
end

# frozen_string_literal: true

RSpec.describe WalletPay do
  it "has a version number" do
    expect(WalletPay::VERSION).not_to be nil
  end

  describe "#configure" do
    let(:token) { "abc123" }
    let(:api_version) { "v2" }
    let(:custom_uri_base) { "ghi789" }
    let(:custom_request_timeout) { 25 }
    let(:extra_headers) { { "User-Agent" => "WalletPay Ruby Gem #{WalletPay::VERSION}" } }

    before do
      WalletPay.configure do |config|
        config.token = token
        config.api_version = api_version
        config.extra_headers = extra_headers
      end
    end

    it "returns the config" do
      expect(WalletPay.configuration.token).to eq(token)
      expect(WalletPay.configuration.api_version).to eq(api_version)
      expect(WalletPay.configuration.url).to eq("https://pay.wallet.tg/wpay/store-api/")
      expect(WalletPay.configuration.request_timeout).to eq(20)
      expect(WalletPay.configuration.extra_headers).to eq(extra_headers)
    end

    context "without an access token" do
      let(:token) { nil }

      it "raises an error" do
        expect { WalletPay::Client.new.orders_list }.to raise_error(WalletPay::ConfigurationError)
      end
    end

    context "with custom timeout and uri base" do
      before do
        WalletPay.configure do |config|
          config.url = custom_uri_base
          config.request_timeout = custom_request_timeout
        end
      end

      it "returns the config" do
        expect(WalletPay.configuration.token).to eq(token)
        expect(WalletPay.configuration.api_version).to eq(api_version)
        expect(WalletPay.configuration.url).to eq(custom_uri_base)
        expect(WalletPay.configuration.request_timeout).to eq(custom_request_timeout)
        expect(WalletPay.configuration.extra_headers).to eq(extra_headers)
      end
    end
  end
end

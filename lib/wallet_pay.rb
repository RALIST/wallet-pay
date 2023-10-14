# frozen_string_literal: true

module WalletPay
  class Error < StandardError; end
  class ConfigurationError < Error; end

  class Configuration
    attr_writer :token
    attr_accessor :api_version, :url, :request_timeout, :connection_open_timeout, :extra_headers

    DEFAULT_URI_BASE = "https://pay.wallet.tg/wpay/store-api/"
    DEFAULT_REQUEST_TIMEOUT = 20
    DEFAULT_API_VERSION = "v1"

    def initialize
      @token = nil
      @extra_headers = nil
      @url = DEFAULT_URI_BASE
      @api_version = DEFAULT_API_VERSION
      @request_timeout = DEFAULT_REQUEST_TIMEOUT
      @connection_open_timeout = DEFAULT_REQUEST_TIMEOUT
    end

    def token
      return @token if @token

      error_text = "WalletPay api token missing!"
      raise ConfigurationError, error_text
    end

    def headers
      {
        "Content-Type" => "application/json",
        "Wpay-Store-Api-Key" => token,
        "Accept" => "application/json"
      }.merge(extra_headers || {})
    end
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= WalletPay::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end

require_relative "wallet_pay/http"
require_relative "wallet_pay/client"

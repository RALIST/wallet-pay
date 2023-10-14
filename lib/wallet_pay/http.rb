# frozen_string_literal: true

require "faraday"

module HTTP
  SUCCESS_STATUSES = [200, 201].freeze
  class ResponseError < StandardError; end

  def get(path:)
    response = conn.get(uri(path: path)) do |req|
      req.headers = headers
    end

    error_or_response(response)
  end

  def json_post(path:, parameters:)
    response = conn.post(uri(path: path)) do |req|
      req.headers = headers
      req.body = parameters.to_json
    end

    error_or_response(response)
  end

  private

  def error_or_response(response)
    return to_json(response.body) if SUCCESS_STATUSES.include?(response.status.to_i)

    raise ResponseError, <<~TXT
      WalletPay api has returned the error
      Status: #{response.status}
      Body: #{to_json(response.body)}
    TXT
  end

  def to_json(string)
    return unless string

    JSON.parse(string)
  rescue JSON::ParserError
    raise ResponseError, "Wallet Pay api returned invalid json #{string}"
  end

  def conn
    @conn ||= Faraday.new do |f|
      f.options.timeout = configuration.request_timeout
      f.options.open_timeout = configuration.connection_open_timeout
    end
  end

  def configuration
    WalletPay.configuration
  end

  def uri(path:)
    File.join(configuration.url, configuration.api_version, path)
  end

  def headers
    configuration.headers
  end
end

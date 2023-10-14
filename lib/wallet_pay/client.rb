# frozen_string_literal: true

module WalletPay
  class Client
    extend HTTP

    def initialize(token: nil, url: nil, request_timeout: nil, extra_headers: nil, api_version: nil)
      WalletPay.configuration.token = token if token
      WalletPay.configuration.url = url if url
      WalletPay.configuration.api_version = api_version if api_version
      WalletPay.configuration.request_timeout = request_timeout if request_timeout
      WalletPay.configuration.extra_headers = extra_headers if extra_headers
    end

    # More info https://docs.wallet.tg/pay/#tag/Order-Reconciliation/operation/getOrderList
    def orders_list(limit: 100, offset: 0)
      WalletPay::Client.get(path: "/reconciliation/order-list?offset=#{offset}&count=#{limit}")
    end

    # More info https://docs.wallet.tg/pay/#tag/Order/operation/getPreview
    def order_preview(order_id:)
      WalletPay::Client.get(path: "/order/preview?id=#{order_id}")
    end

    # More info https://docs.wallet.tg/pay/#tag/Order-Reconciliation/operation/getOrderAmount
    def orders_amount
      WalletPay::Client.get(path: "/reconciliation/order-amount")
    end

    # More info https://docs.wallet.tg/pay/#tag/Order/operation/create
    def create_order(amount:, description:, user_id:, external_id:, **params)
      WalletPay::Client.json_post(path: "/order",
                                  parameters: order_params(amount, description, user_id, external_id, params))
    end

    private

    def order_params(amount, description, user_id, external_id, params) # rubocop:disable Metrics/MethodLength
      return_url = params[:return_url]
      fail_return_url = params[:fail_return_url]
      custom_data = params[:custom_data]
      timeout = params[:timeout] || 864_000
      currency = params[:currency] || "USD"

      {
        amount: {
          currencyCode: currency,
          amount: amount
        },
        description: description,
        externalId: external_id,
        timeoutSeconds: timeout,
        customerTelegramUserId: user_id,
        returnUrl: return_url,
        failReturnUrl: fail_return_url,
        customData: custom_data
      }
    end
  end
end

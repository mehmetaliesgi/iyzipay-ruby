module Iyzipay
  module Model
    class Payment < IyzipayResource

      def create(request = {}, options)
        request_string = to_pki_string(request)
        HttpClient.post("#{options.base_url}/payment/iyzipos/auth/ecom", get_http_header(request_string, options), request.to_json)
      end

      def to_pki_string(request)
        PkiBuilder.new.append_super(super).
            append_price(:price, request[:price]).
            append_price(:paidPrice, request[:paidPrice]).
            append(:installment, request[:installment]).
            append(:paymentChannel, request[:paymentChannel]).
            append(:basketId, request[:basketId]).
            append(:paymentGroup, request[:paymentGroup]).
            append(:paymentCard, PaymentCard.to_pki_string(request[:paymentCard])).
            append(:buyer, Buyer.to_pki_string(request[:buyer])).
            append(:shippingAddress, Address.to_pki_string(request[:shippingAddress])).
            append(:billingAddress, Address.to_pki_string(request[:billingAddress])).
            append_array(:basketItems, Basket.to_pki_string(request[:basketItems])).
            append(:paymentSource, request[:paymentSource]).
            get_request_string
      end
    end
  end
end
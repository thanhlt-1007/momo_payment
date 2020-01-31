class Momo::JsonRequestService < Momo::ApplicationService
  def perform
    {
      partnerCode: partner_code,
      accessKey: access_key,
      requestId: request_id,
      amount: amount,
      orderId: order_id,
      orderInfo: order_info,
      returnUrl: return_url,
      notifyUrl: notify_url,
      extraData: extra_data,
      requestType: request_type,
      signature: signature
    }
  end

  private

  def request_type
    @request_type ||= Settings.momo.payment.requestType
  end

  def signature
    raw_signature = "partnerCode=" + partner_code +
      "&accessKey=" + access_key +
      "&requestId=" + request_id +
      "&amount=" + amount +
      "&orderId=" + order_id +
      "&orderInfo=" + order_info +
      "&returnUrl=" + return_url +
      "&notifyUrl=" + notify_url +
      "&extraData=" + extra_data

    @signature ||= OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), secret_key, raw_signature)
  end
end

class Momo::Aio::JsonRequestService < Momo::ApplicationService
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

  def return_url
    @return_url ||= momo_aio_payment_url(id: order.id)
  end

  def notify_url
    @notify_url ||= momo_aio_payment_url(id: order.id)
  end

  def request_type
    @request_type ||= Settings.momo.requestType.aio
  end

  def raw_signature
    raw_signature = "partnerCode=" + partner_code +
      "&accessKey=" + access_key +
      "&requestId=" + request_id +
      "&amount=" + amount +
      "&orderId=" + order_id +
      "&orderInfo=" + order_info +
      "&returnUrl=" + return_url +
      "&notifyUrl=" + notify_url +
      "&extraData=" + extra_data
  end
end

class Momo::Aio::PaymentService < Momo::PaymentService
  private

  def json_request
    @json_request ||= Momo::Aio::JsonRequestService.new(order).perform
  end
end

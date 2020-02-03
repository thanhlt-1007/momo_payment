class Momo::ApplicationService
  include Rails.application.routes.url_helpers
  default_url_options[:host] = ENV["HOST"]

  attr_reader :order

  def initialize order
    @order = order
  end

  protected

  def secret_key
    ENV["SECRET_KEY"]
  end

  def partner_code
    ENV["PARTNER_CODE"]
  end

  def access_key
    ENV["ACCESS_KEY"]
  end

  def request_id
    @request_id ||= SecureRandom.uuid
  end

  def amount
    @amount ||= order.price.to_s
  end

  def order_id
    @order_id ||= "#{order.id}_#{Time.zone.now.to_i}_#{SecureRandom.uuid}"
  end

  def order_info
    @order_info ||= "TpT MoMo #{order.name}"
  end

  def extra_data
    @extra_data ||= ""
  end

  def signature
    @signature ||= OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), secret_key, raw_signature)
  end
end

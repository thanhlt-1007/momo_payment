class Momo::PaymentService < Momo::ApplicationService
  attr_reader :success, :pay_url, :error_message

  def perform
    load_uri
    load_http
    load_request
    execute_request

    @success = @result["errorCode"] == 0
    if @success
      @pay_url = @result["payUrl"]
    else
      @error_message = @result["localMessage"]
    end
  end

  private

  def load_uri
    @uri = URI.parse payment_url
  end

  def load_http
    @http = Net::HTTP.new @uri.host, @uri.port
    @http.use_ssl = true
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  def load_request
    @request = Net::HTTP::Post.new @uri.path
    @request.add_field "Content-Type", "application/json"
    @request.body = json_request.to_json
  end

  def execute_request
    @response = @http.request @request
    @result = JSON.parse @response.body
  end

  def payment_url
    Rails.env.production? ? Settings.momo.url.production : Settings.momo.url.test
  end
end

class Momo::Aio::PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :update
  before_action :load_order

  def create
    service = Momo::Aio::PaymentService.new @order
    service.perform

    if service.success
      redirect_to service.pay_url
    else
      flash[:danger] = service.error_message
      redirect_to root_url
    end
  end

  def show
    payment_result
  end

  def update
    payment_result
  end

  private

  def load_order
    @order = Order.find_by id: (params[:id] || params[:order_id])
    return if @order

    flash[:danger] = "Order not found"
    redirect_to root_url
  end

  private

  def payment_result
    success = params[:errorCode] == "0"
    message = params[:localMessage]

    if success
      flash[:success] = message
    else
      flash[:danger] = message
    end

    redirect_to root_url
  end
end

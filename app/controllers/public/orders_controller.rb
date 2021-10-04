class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @order.customer_id = current_customer.id
  end

  def confirm#注文確認newページから受け渡し。
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
  end

  def create#注文確定（注文情報入力画面で確定するボタンを押してデータ保存）
    # @order = Order.new(order_params)
    # @order.save
    # redirect_to orders_confirm_path(@order.id)
  end

  def complete
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end

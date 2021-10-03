class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @order.customer_id = current_customer.id
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to orders_confirm_path(@order.id)
  end

  def confirm
  end

  def complete
  end

  def index
  end

  def show
  end

end

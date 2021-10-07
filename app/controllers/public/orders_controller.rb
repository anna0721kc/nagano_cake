class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @order.customer_id = current_customer.id
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @sum = 0#初期値として必要
    @order.shipping_cost = 800#今回は固定で800円なので

    if params[:order][:select_address] == "0"#自分の住所
       @order.postal_code = current_customer.postal_code
       @order.address = current_customer.address
       @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:select_address] == "1"#登録済み住所
       @address = Address.find(params[:order][:address_id])
       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name

    elsif params[:order][:select_address] == "2"#新しいお届け先
       @order.postal_code = params[:order][:postal_code]
       @order.address = params[:order][:address]
       @order.name = params[:order][:name]
    end
  end

#注文確定（注文情報入力画面で確定するボタンを押してデータ保存）
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    redirect_to orders_complete_path
  end

  def complete

  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :shipping_cost)#もあとで足す
  end
end

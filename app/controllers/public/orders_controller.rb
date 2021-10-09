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
    @order = Order.new(order_params)#confirmからの情報を受け取るためにparams忘れずに書く！！
    @order.customer_id = current_customer.id
    @order.save
    #order_detailへの保存
    current_customer.cart_items.each do |cart_item|#カートの商品を1つずつ取り出しループ
         @order_detail = OrderDetail.new#初期化宣言
         @order_detail.order_id =  @order.id#order注文idを紐付け
         @order_detail.item_id = cart_item.item_id
         @order_detail.amount = cart_item.amount
         @order_detail.price = cart_item.subtotal#税込み価格
         @order_detail.save#注文商品を保存
        end
        current_customer.cart_items.destroy_all
        redirect_to orders_complete_path
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])

  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :shipping_cost)#もあとで足す
  end
end

#管理者側ordersコントローラ
class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details#４行目の@order
    @sum = 0
  end

  def update
    @order = Order.find(params[:id])
    #ステータスif文
    #注文ステータスが入金確認 → 全ての製作ステータスを製作待ち
    @order.update(order_params)
    if @order.status == "paid_up"
       @order.order_details.each do |order_detail|
         order_detail.update(making_status:"waiting")
       end
    end
    redirect_to admin_order_path(@order.id)
  end


  private
  def order_params
    params.require(:order).permit(:status)
  end
end

#管理者側／order_detailsコントローラ
class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    #製作ステータスが一つでも製作中 → 注文ステータスを製作中
    @order_detail.update(order_detail_params)
    if @order_detail.making_status == "making"
       @order_detail.order.update(status:"production")
#製作ステータスが全て 製作完了 → 注文ステータスを 発送準備中
    elsif
      order_details = @order_detail.order.order_details
      boolean = true#フラグ変数。trueが初期値
      order_details.each do |order_detail|
        if order_detail.making_status != "complete"#製作ステータスが製作完了になっていないなら、
          boolean = false#フラグはfalseになる
        end
      end

      if boolean#trueは初期値。「== true」は書かなくてもOK
        @order_detail.order.update(status:"preparing")#trueだったら、注文ステータスを発送準備中に変更
      end
    end
    redirect_to admin_order_path(@order_detail.order.id)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
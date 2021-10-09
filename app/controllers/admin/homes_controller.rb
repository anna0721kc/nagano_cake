class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!


  def top
    @orders = Order.all.page(params[:page]).per(10)
    @sum = 0#注文数合計
    #モデル同士紐付けしているのでorder_detail、cutomerの定義しない]
  end

end

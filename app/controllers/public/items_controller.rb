class Public::ItemsController < ApplicationController
  #showもindexもログインしていなくても見られるようにするので「before_action :authenticate_customer!」は不要
  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
  end

  def index
    @items = Item.where(is_active: true).page(params[:page]).per(8)
  end
end
class Public::ItemsController < ApplicationController
  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
  end

  def index
    @items = Item.where(is_active: true).page(params[:page]).per(8)
  end
end
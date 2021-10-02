class Public::ItemsController < ApplicationController
  #public/商品一覧・詳細
  def show
    @item = Item.find(params[:id])

  end

  def index
    @items = Item.all.page(params[:page]).per(8)
  end


end

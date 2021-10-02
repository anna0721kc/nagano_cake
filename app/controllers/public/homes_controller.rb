class Public::HomesController < ApplicationController
  def top
    @items = Item.where(is_active: "販売中")
  end

  def about
  end
end

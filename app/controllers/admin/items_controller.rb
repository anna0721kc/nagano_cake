class Admin::ItemsController < ApplicationController
  #admin／商品一覧画面
  before_action :authenticate_admin!
  def index
      @items = Item.all.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def create
      @item = Item.new(item_params)
      @item.save
      redirect_to admin_item_path(@item)
  end



def show
    @item = Item.find(params[:id])
end

def edit
    @item = Item.find(params[:id])
end

def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
        flash[:notice] = "You have updated genre successfully."
        redirect_to admin_item_path
    else
        render :edit
    end
end

private
  def item_params
    params.require(:item).permit(:genre_id, :image, :name, :introduction, :price, :is_active)
  end

end
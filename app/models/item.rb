class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  
  belongs_to :genre
  attachment :image
  #消費税を求めるメソッド↓
  def with_tax_price
    (self.price * 1.1).floor
  end


#販売ステータス↓
  validates :is_active, inclusion: {in: [true, false]}
end

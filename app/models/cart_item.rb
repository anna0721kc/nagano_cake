class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :amount, presence: true

  #小計を求めるメソッド
  def subtotal
    self.item.with_tax_price * self.amount
  end
end

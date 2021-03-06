class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  enum making_status: { discontinued: 0, waiting: 1, making: 2, complete: 3 }

#小計を求めるメソッド
  def subtotal
    self.item.with_tax_price * self.amount
  end
end

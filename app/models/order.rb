class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  enum status: { waiting: 0, paid_up: 1, production: 2, preparing: 3, shipped: 4}
  enum payment_method: { credit_card: 0, transfer: 1}
end

class Address < ApplicationRecord
  belongs_to :customer
  #注文情報入力画面の登録済みアドレス
  def full_address
    '〒' + postal_code + ' ' + address + ' ' + name
  end
end

class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  #バリデーション
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: {
                               with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
                               message: "姓カナは全角カタカナのみで入力して下さい"
                             }
  validates :first_name_kana, presence: true, format: {
                               with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
                               message: "名カナは全角カタカナのみで入力して下さい"
                             }
  validates :postal_code, presence: true, format: {
                               with: /\A\d{7}\z/,
                               message: "郵便番号はハイフンなしの７桁で入力してください"
                             }
  validates :telephone_number, presence: true, format: {
                               with: /\A\d{10,11}\z/,
                               message: "電話番号は10桁か11桁で入力してください"
                             }

end

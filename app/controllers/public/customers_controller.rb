class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer#URLが「/mypage」なので、idを使用しないため
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
       flash[:notice] = "You have updated data successfully."
       redirect_to customers_my_page_path(@customer)
    else
       render :edit
    end
  end

  def unsubscribe#顧客の退会確認
    @customer = current_customer
  end

  def withdraw#顧客の退会処理(ステータスの更新)
    @customer = current_customer
    if @customer.update(is_deleted: false)
      sign_out current_customer
    end
    redirect_to root_path
  end
  private
def customer_params
 params.require(:customer).permit(:last_name, :first_name,:last_name_kana, :first_name_kana, :email, :encrypted_password,:postal_code, :address, :telephone_number, :is_deleted)
end

def ensure_correct_customer
    @customer = current_customer
    if current_customer != @customer
       redirect_to root_path
    end
end

end
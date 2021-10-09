Rails.application.routes.draw do
  devise_for :customers, controllers: {
  registrations: 'public/registrations',
  sessions: 'public/sessions',
  }
  devise_for :admins,path: 'admin',controllers: {
  registrations: 'admin/registrations',
  sessions: 'admin/sessions',
  }



  #public会員側
  scope module: :public do
  root to: 'homes#top'
  get '/about' => 'homes#about'
  resources :items, only: [:show, :index]
  get '/customers/my_page' => 'customers#show'
  get '/customers/edit' => 'customers#edit'
  patch '/customers/edit' => 'customers#update'
  get '/customers/unsubscribe' => 'customers#unsubscribe'#顧客の退会確認画面
  patch '/customers/withdraw' => 'customers#withdraw'#会員ステータスの切替
  post '/orders/confirm' => 'orders#confirm'
  delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
  resources :cart_items, only: [:index, :update, :destroy, :create]
  get '/orders/complete' => 'orders#complete'
  resources :orders, only: [:new, :index, :show, :create]
  resources :addresses, except: [:new, :show]
  end
  #admin管理側
  namespace :admin do
    get '/' => 'homes#top'
    resources :items, except: [:destroy]
    resources :genres, except: [:new, :show, :destroy]
    resources :customers, only: [:show, :index, :edit, :update]
    resources :orders, only: [:show, :update]
    patch '/order_details/:id' => 'order_details#update'
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

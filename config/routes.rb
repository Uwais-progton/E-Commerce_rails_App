Rails.application.routes.draw do
 
  resource :registration
  resource :session
  resource :password_reset
  resource :password
  root "main#index"
  resources :products
  resource :cart, only: [:show]
  post 'add_to_cart/:product_id', to: 'carts#add_to_cart', as: 'cart_add_to_cart'
  delete 'remove_from_cart/:id', to: 'carts#remove_from_cart', as: 'remove_from_cart'

end

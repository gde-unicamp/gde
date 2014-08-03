Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root to: 'dashboard#feed', as: 'user_root'
  end
  unauthenticated do
    root to: 'home#index'
  end
end

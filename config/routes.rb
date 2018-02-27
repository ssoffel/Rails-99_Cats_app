Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cats, only: [:index, :show, :new, :create, :edit, :update]

  resources :cat_rental_requests, only: [:new, :create] do
    member do
      patch :approve, to: 'cat_rental_requests#approve'
      patch :deny, to: 'cat_rental_requests#deny'
    end
  end
end

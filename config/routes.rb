Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :questions do
    resources :answers, only: %i[create destroy]
  end

  root "pages#index"
end

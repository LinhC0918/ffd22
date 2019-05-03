Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "products#index"

    get "password_resets/new"
    get "password_resets/edit"
    get "static_pages/home"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/carts", to: "carts#show"
    post "carts/create"
    delete "carts/destroy"
    post "carts/update"
    post "comments/:id/edit", to: "comments#edit", as: "edit_comment"

    resources :users, :products, :categories, :suggestions
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index destroy show)
    resources :comments, only: %i(create update destroy)
    resources :orders, except: %i(new edit)
  end
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/articles", to: "articles#get"
  get "/articles/:id", to: "articles#getById"
  post "/articles", to: "articles#create"
  put "/articles/:id", to: "articles#update"
  delete "/articles/:id", to: "articles#delete"

  post "/login", to: "users#login"
  post "/signup", to: "users#create"
end

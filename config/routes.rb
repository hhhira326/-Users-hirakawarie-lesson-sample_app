Rails.application.routes.draw do
  root "static_pages#home"
  get '/help', to:'static_pages#help' 
  get '/about', to:"static_pages#about"
  get '/contact', to: "static_pages#contact"
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  #ユーザー情報を表示するURL (/users/1) を追加するためだけのものではなく、ユーザーのURLを生成するための多数の名前付きルートと共に、RESTfulなUsersリソースで必要となるすべてのアクションが利用できるようになる。
end

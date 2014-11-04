Rails.application.routes.draw do
  resources :goals

  resources :users
  resource :session

end

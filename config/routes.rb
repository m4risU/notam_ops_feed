Rails.application.routes.draw do
  resources :notams
  root to: 'notams#index'
end

Rails.application.routes.draw do
  get 'projects/:id/assign', to: 'projects#assign'
  get 'bugs/:id/:pid/assign', to: 'bugs#assign'
  get 'projects/:id/:user_id/remove', to: 'projects#remove'
  get 'projects/searchproject', to: 'projects#searchproject'
  resources :projects
  resources :bugs
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "projects#home"
end

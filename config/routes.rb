Rails.application.routes.draw do
  mount Hyperloop::Engine => '/hyperloop'
  # root 'hyperloop#app' # route just the root to the component named App
  get '/(*other)', to: 'hyperloop#app' # route everything to the App component
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

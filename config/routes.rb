Rails.application.routes.draw do
  mount Hyperloop::Engine => "/hyperloop"
  get '/(*other)', to: 'hyperloop#app'
end

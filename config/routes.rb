Rails.application.routes.draw do
  mount Hyperloop::Engine => "/hyperloop"
  get '/(*other)', to: 'todos#app'
end

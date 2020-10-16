Rails.application.routes.draw do

  get "video/home" => "video#home"
  get "login" => "user#login"
  get "home" => "user#home"
  get "error" => "user#error"
  get "userError" => "user#userError"
  get "logout" => "user#logout"
  post "interest" => "api#getInterest"


  post 'user/register' => "user#register"

  resources :video

  get 'auth/:provider/callback', to: 'sessions#omniauth'
  get 'auth/failure', to: redirect('/')


end

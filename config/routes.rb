Rails.application.routes.draw do

  get "video/home" => "video#home"
  get "login" => "user#login"
  get "home" => "user#home"
  get "error" => "user#error"
  get "userError" => "user#userError"
  get "logout" => "user#logout"
  post "interest" => "api#getInterest"
  post "newinterest" => "api#newInterest"
  post "clearinterest" => "api#clearInterest"
  post "insertinterest" => "api#insertInterest"
  post "insertConcept" => "api#insertConcept"

  get "/" => "application#home"
  post "newVideo" => "api#newVideo"
  post "like" => "api#like"

  get "creator/add" => "creator#add"
  post "creator/add" => "creator#addTutorial"
  
  get 'tutorials' => "video#list"

  post 'user/register' => "user#register"

  resources :video

  get 'auth/:provider/callback', to: 'sessions#omniauth'
  # get 'auth/failure', to: redirect('/login')


end

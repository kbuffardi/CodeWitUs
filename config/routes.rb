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
  post "userList" => "api#getUser"
  post "updateRole" => "api#accessUser"

  post "newAlert" => "api#newAlert"
  post "editAlert" => "api#editAlert"


  
  get "/" => "application#home"
  post "newVideo" => "api#newVideo"
  post "like" => "api#like"

  get "creator/add" => "creator#add"
  post "creator/add" => "creator#addTutorial"
  get "with/:userid" => "creator#profile"
  get "creator/alert" => "creator#alert"
  get "creator/editalert" => "creator#editalert"


  get 'tutorials' => "video#list"

  post 'user/register' => "user#register"

  get 'manage' => "manage#home"


  resources :video

  get 'auth/:provider/callback', to: 'sessions#omniauth'
  # get 'auth/failure', to: redirect('/login')

  get '*path', :to =>  "application#error"


end

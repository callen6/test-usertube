Usertube::Application.routes.draw do
  devise_for :users,
             controllers: {omniauth_callbacks: "omniauth_callbacks"}
   root "users#index"
  
end

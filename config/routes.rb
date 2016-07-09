Rails.application.routes.draw do
 

 
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'

   post '/usershapes' => "home#create",defaults: {format: :json}
   put '/usershapes' => "home#update",defaults: {format: :json}
   get '/usershapes'  => "home#usershapes", defaults: {format: :json}
  
end

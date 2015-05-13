Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests
  post "cat_rental_requests/url" => ""
end

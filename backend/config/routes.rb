Rails.application.routes.draw do
  namespace :api do
    resources :places, only: [:index, :show]
  end
end

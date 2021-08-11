Rails.application.routes.draw do
  # Api definition
  namespace :api, default: {format: 'json'} do
    namespace :v1 do
      resources :users, only: [:show, :create, :update, :destroy]
    end
  end
end

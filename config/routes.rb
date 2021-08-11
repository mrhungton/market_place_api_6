Rails.application.routes.draw do
  # Api definition
  namespace :api, default: {format: 'json'} do
    namespace :v1 do
      resources :users, only: %i[show create update]
    end
  end
end

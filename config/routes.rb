Rails.application.routes.draw do
  root "orders#index"

  namespace :momo do
    namespace :aio do
      resources :payments, only: %i(create show) do
        member do
          post :update
        end
      end
    end
  end
end

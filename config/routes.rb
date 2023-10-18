Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :movies do
    member do
      get 'reservation'
      get 'schedules/:schedule_id/reservations/new', to: 'movies#new_reservation', as: 'new_reservation'
    end
  end

  # 予約データの保存
  resources :reservations, only: [:new, :create]

  namespace :admin do
    resources :reservations
    resources :movies do
      resources :schedules
    end
  end

  resources :sheets
end

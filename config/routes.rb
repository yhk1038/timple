Rails.application.routes.draw do
    
    devise_for :users, controllers: {
            sessions: 'users/sessions',
            registrations: 'users/registrations',
            confirmations: 'users/confirmations',
            passwords: 'users/passwords',
            omniauth_callbacks: 'users/omniauth_callbacks'
    }
    match '/oauth', to: 'users/omniauth_callbacks#kakao', via: [:get, :post, :put, :delete]
    
    root 'util#balancer'
    get '/landing', to: 'util#landing', as: 'landing'
    get 'util/index', to: 'util#index', as: 'intro'
    get 'timetable/intro', to: 'timetables#intro', as: 'table'

    resources :groups do
        resources :timetables
        resources :marks
    end
end

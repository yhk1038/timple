Rails.application.routes.draw do
    
    devise_for :users, controllers: {
            sessions: 'users/sessions'
    }
    
    root 'util#landing'
    get 'util/index'
    get 'timetable/intro', to: 'timetables#intro', as: 'table'

    resources :groups do
        resources :timetables
        resources :marks
    end
end

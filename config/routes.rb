Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  namespace :api do
    namespace :v1 do
      # Employee resources
      resources :employees do
        member do
          get :salary_history
          get :direct_reports
        end
      end

      # Reference data
      resources :job_titles, only: [:index, :show]
      resources :departments, only: [:index, :show]
      resources :work_locations, only: [:index, :show]

      # Insights endpoints
      namespace :insights do
        get :dashboard
        get :salary_by_country
        get :salary_by_job_title
      end
    end
  end
end

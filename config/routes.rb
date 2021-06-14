Rails.application.routes.draw do
  resources :plots, only: [:index]

  delete '/plots/:plot_id/plot_plants/:plant_id', to: 'plot_plants#destroy'
end

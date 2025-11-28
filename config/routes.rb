Rails.application.routes.draw do
  resources :products

  # Google Sheets import için route
  post "products/import_from_sheet", to: "products#import_from_sheet", as: :import_products

  # Sağlık kontrolü ve diğer varsayılan route’lar
  get "up" => "rails/health#show", as: :rails_health_check

  # root path
  root "products#index"
end
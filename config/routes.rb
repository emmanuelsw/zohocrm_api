Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :leads
      get 'search_by_leadsource', to: 'leads#search_by_leadsource'
    end
  end

end

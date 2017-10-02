Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :leads do
        collection do
          get 'search_phone'
          get 'search_leadsource'
          get 'search'
        end
      end
      mount ActionCable.server => '/cable'
    end
  end

end

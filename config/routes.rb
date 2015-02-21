Rails.application.routes.draw do

  resources :shifts, except: [:show]
  resources :workers do
    collection do
      get :autocomplete_for
    end
    member do
      get :new_allotment
      post :create_allotment
      delete :destroy_allotment
    end
  end

  devise_for :users

  resources :users do
    member do
      get :edit_profile
      patch :update_profile
    end
  end

  root to: redirect('/shifts')
end

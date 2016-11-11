Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :documents do
    member do
      get :download, param: :file_url
      post :show, param: :file_url
    end
  end

  root to: redirect('/documents')
end

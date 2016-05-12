EmailMe::Engine.routes.draw do
  resources :mail_templates, only: [:index, :edit, :update] do
    member do
      post 'preview'
    end
  end
  root 'mail_templates#index'
end

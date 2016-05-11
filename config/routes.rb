EmailMe::Engine.routes.draw do
  resources :mail_templates do
    member do
      post 'preview'
    end
  end
  root 'mail_templates#index'
end

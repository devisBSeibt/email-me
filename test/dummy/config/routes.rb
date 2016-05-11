Rails.application.routes.draw do

  mount EmailMe::Engine => "/email_me"
end

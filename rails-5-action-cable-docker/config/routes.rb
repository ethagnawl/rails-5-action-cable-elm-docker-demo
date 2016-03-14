Rails.application.routes.draw do
  root 'scores#show'
  mount ActionCable.server => '/cable'
end

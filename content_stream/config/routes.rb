Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'contents#search'

  get 'search' => 'contents#search', as: 'search'
  post 'like' => 'contents#like', as: 'like'
  post 'dislike' => 'contents#dislike', as: 'dislike'

end

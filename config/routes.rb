SurvivalPack::Application.routes.draw do
  get 'survival/index'
  mount API => '/'
  root 'survival#index'
end

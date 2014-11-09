class API < Grape::API
  prefix 'v1/survival-pack'
  mount Survival::Raise
  mount Survival::Post
  mount Survival::Get
end

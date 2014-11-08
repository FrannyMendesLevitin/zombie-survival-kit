class API < Grape::API
  prefix 'v1/survival-pack'
  mount Survival::Ping
  mount Survival::Raise
  mount Survival::Protected
  mount Survival::Post
end

class API < Grape::API
  prefix 'v1/survival-pack'
  mount Acme::Ping
  mount Acme::Raise
  mount Acme::Protected
  mount Acme::Post
end

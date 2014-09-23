json.array!(@publics) do |public|
  json.extract! public, :id, :name, :password, :tp
  json.url public_url(public, format: :json)
end

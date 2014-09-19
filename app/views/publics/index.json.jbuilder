json.array!(@publics) do |public|
  json.extract! public, :id, :name, :password, :type
  json.url public_url(public, format: :json)
end

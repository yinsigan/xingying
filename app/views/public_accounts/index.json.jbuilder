json.array!(@public_accounts) do |public_account|
  json.extract! public_account, :id, :name, :tp
  json.url public_account_url(public_account, format: :json)
end

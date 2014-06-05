json.array!(@user_clients) do |user_client|
  json.extract! user_client, :id, :user_id, :client_id
  json.url user_client_url(user_client, format: :json)
end

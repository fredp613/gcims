json.array!(@modelstates) do |modelstate|
  json.extract! modelstate, :id, :user_id, :state, :object
  json.url modelstate_url(modelstate, format: :json)
end

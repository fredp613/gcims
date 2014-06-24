json.array!(@customtemplatetypes) do |customtemplatetype|
  json.extract! customtemplatetype, :id, :type, :modelstate_id
  json.url customtemplatetype_url(customtemplatetype, format: :json)
end

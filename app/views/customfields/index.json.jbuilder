json.array!(@customfields) do |customfield|
  json.extract! customfield, :id, :field_type, :field_name, :field_class
  json.url customfield_url(customfield, format: :json)
end

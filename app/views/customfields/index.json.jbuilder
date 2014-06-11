json.array!(@customfields) do |customfield|
  json.extract! customfield, :id, :customtemplate_id, :type, :name, :class
  json.url customfield_url(customfield, format: :json)
end

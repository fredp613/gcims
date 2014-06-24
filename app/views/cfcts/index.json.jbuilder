json.array!(@cfcts) do |cfct|
  json.extract! cfct, :id, :customfield_id, :customtemplate_id
  json.url cfct_url(cfct, format: :json)
end

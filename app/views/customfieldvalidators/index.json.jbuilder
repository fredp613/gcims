json.array!(@customfieldvalidators) do |customfieldvalidator|
  json.extract! customfieldvalidator, :id, :customfield_id, :type
  json.url customfieldvalidator_url(customfieldvalidator, format: :json)
end

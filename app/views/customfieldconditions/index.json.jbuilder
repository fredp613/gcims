json.array!(@customfieldconditions) do |customfieldcondition|
  json.extract! customfieldcondition, :id, :customfieldvalidator_id, :condition
  json.url customfieldcondition_url(customfieldcondition, format: :json)
end

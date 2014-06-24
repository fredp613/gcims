json.array!(@customfieldvalues) do |customfieldvalue|
  json.extract! customfieldvalue, :id, :value, :user_id, :wizardcustomtemplate_id
  json.url customfieldvalue_url(customfieldvalue, format: :json)
end

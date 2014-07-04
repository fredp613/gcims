json.array!(@applicationcustomtemplates) do |applicationcustomtemplate|
  json.extract! applicationcustomtemplate, :id, :user_id, :application_id, :customtemplate_id
  json.url applicationcustomtemplate_url(applicationcustomtemplate, format: :json)
end

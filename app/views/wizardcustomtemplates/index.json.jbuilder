json.array!(@wizardcustomtemplates) do |wizardcustomtemplate|
  json.extract! wizardcustomtemplate, :id, :user_id, :customtemplate_id, :wizard_id
  json.url wizardcustomtemplate_url(wizardcustomtemplate, format: :json)
end

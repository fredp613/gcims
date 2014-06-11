json.array!(@customtemplates) do |customtemplate|
  json.extract! customtemplate, :id, :commitmentitem_id, :name
  json.url customtemplate_url(customtemplate, format: :json)
end

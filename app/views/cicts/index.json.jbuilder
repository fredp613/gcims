json.array!(@cicts) do |cict|
  json.extract! cict, :id, :commitmentitem_id, :customtemplate_id
  json.url cict_url(cict, format: :json)
end

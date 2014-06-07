json.array!(@wizards) do |wizard|
  json.extract! wizard, :id, :user_id
  json.url wizard_url(wizard, format: :json)
end

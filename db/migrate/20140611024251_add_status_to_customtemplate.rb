class AddStatusToCustomtemplate < ActiveRecord::Migration
  def change
  	add_column :customtemplates, :active, :boolean
  end
end

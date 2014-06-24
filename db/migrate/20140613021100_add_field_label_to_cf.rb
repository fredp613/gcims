class AddFieldLabelToCf < ActiveRecord::Migration
  def change
  	add_column :customfields, :field_label, :string
  end
end

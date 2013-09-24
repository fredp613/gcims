class AddActiveColToPsl < ActiveRecord::Migration
  def change
    add_column :productservicelines, :active, :boolean
  end
end

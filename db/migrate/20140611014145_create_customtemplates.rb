class CreateCustomtemplates < ActiveRecord::Migration
  def change
    create_table :customtemplates do |t|
      t.references :commitmentitem, index: true
      t.string :name

      t.timestamps
    end
  end
end

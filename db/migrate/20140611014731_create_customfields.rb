class CreateCustomfields < ActiveRecord::Migration
  def change
    create_table :customfields do |t|
      t.references :customtemplate, index: true
      t.string :type
      t.string :name
      t.string :class

      t.timestamps
    end
  end
end

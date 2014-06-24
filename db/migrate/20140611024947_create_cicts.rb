class CreateCicts < ActiveRecord::Migration
  def change
    create_table :cicts do |t|
      t.references :commitmentitem, index: true
      t.references :customtemplate, index: true

      t.timestamps
    end
  end
end

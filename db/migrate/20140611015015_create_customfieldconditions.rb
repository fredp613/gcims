class CreateCustomfieldconditions < ActiveRecord::Migration
  def change
    create_table :customfieldconditions do |t|
      t.references :customfieldvalidator, index: true
      t.string :condition

      t.timestamps
    end
  end
end

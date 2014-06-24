class CreateCustomfieldvalues < ActiveRecord::Migration
  def change
    create_table :customfieldvalues do |t|
      t.string :value
      t.references :user, index: true
      t.references :wizardcustomtemplate, index: true

      t.timestamps
    end
  end
end

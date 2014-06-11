class CreateCustomfieldvalidators < ActiveRecord::Migration
  def change
    create_table :customfieldvalidators do |t|
      t.references :customfield, index: true
      t.string :type

      t.timestamps
    end
  end
end

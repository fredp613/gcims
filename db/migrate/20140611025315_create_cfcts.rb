class CreateCfcts < ActiveRecord::Migration
  def change
    create_table :cfcts do |t|
      t.references :customfield, index: true
      t.references :customtemplate, index: true

      t.timestamps
    end
  end
end

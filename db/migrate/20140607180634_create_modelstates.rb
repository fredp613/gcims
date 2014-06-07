class CreateModelstates < ActiveRecord::Migration
  def change
    create_table :modelstates do |t|
      t.references :user, index: true
      t.string :state
      t.string :object

      t.timestamps
    end
  end
end

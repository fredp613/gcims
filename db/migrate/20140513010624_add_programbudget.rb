class AddProgrambudget < ActiveRecord::Migration
  def change
  	  create_table :programbudgets do |t|
      t.string :fiscalyear
      t.decimal :amount
      t.references :user
      t.references :commitmentitems
      t.timestamps
    end


  end
end

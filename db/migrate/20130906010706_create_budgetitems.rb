class CreateBudgetitems < ActiveRecord::Migration
  def change
    create_table :budgetitems do |t|
      t.string :title
      t.text :desc
      t.decimal :forecast
      t.decimal :actual
      t.integer :fiscalyear_id
      t.integer :application_id
      t.integer :budgetcategory_id

      t.timestamps
    end
  end
end

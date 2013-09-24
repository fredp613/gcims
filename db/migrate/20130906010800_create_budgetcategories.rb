class CreateBudgetcategories < ActiveRecord::Migration
  def change
    create_table :budgetcategories do |t|
      t.string :name

      t.timestamps
    end
  end
end

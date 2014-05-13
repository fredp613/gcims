class AddCostCenterBudget < ActiveRecord::Migration
  def change  	
  	create_table :program_budgets do |t|
      t.string :amount
      t.references :commitmentitems, index: true
      t.string :fiscal_year
      t.references :user     
      t.timestamps
    end 
  end
end


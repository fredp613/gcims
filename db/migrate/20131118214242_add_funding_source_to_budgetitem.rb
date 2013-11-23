class AddFundingSourceToBudgetitem < ActiveRecord::Migration
  def change
  	add_column :budgetitems, :funding_source, :string
  end
end

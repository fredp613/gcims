class RemoveProgrambudget < ActiveRecord::Migration
  def change
  	drop_table :program_budgets
  end
end

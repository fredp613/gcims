class ChangeBudgetiemFiscalyearDatatype < ActiveRecord::Migration
  def up
  	change_column :budgetitems, :fiscalyear_id, :string
  end

  def down
  	change_column :budgetitems, :fiscalyear_id, :integer
  end
end

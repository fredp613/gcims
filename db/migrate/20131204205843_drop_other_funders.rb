class DropOtherFunders < ActiveRecord::Migration
  def up
  	drop_table :other_funders
  end

  def down
  end
end

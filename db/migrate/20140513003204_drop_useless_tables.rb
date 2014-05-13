class DropUselessTables < ActiveRecord::Migration
  def change
  	drop_table 'fiscalyears_commitmentitems'
  	drop_table 'fiscalyears_summarycommitments'
  	drop_table 'fiscalyears_subservicelines'
  	drop_table 'fiscalyears_productservicelines'
  end
end

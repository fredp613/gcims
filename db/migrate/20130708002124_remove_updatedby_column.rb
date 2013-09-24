class RemoveUpdatedbyColumn < ActiveRecord::Migration
  def change
  	remove_column :productservicelines, :updated_by
  	remove_column :subservicelines, :updated_by
  	remove_column :summarycommitments, :updated_by
  	remove_column :commitmentitems, :updated_by
  end

end

class RenameSalutionds < ActiveRecord::Migration
  def up
  	rename_column :contacts, :salution, :salutation
  end

  def down
  end
end

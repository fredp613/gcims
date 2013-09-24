class RenameSalutions < ActiveRecord::Migration
  def up
  	rename_column :contacts, :saluations, :salutation
  end

  def down
  end
end

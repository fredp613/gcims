class RenameTypeToNameContactType < ActiveRecord::Migration
  def up
  	rename_column :contacttypes, :type, :name
  end

  def down
  end
end

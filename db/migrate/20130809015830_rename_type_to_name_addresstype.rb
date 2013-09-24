class RenameTypeToNameAddresstype < ActiveRecord::Migration
  def up
  	rename_column :addresstypes, :type, :name
  end

  def down
  end
end

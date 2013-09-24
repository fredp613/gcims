class CreateAddresstypes < ActiveRecord::Migration
  def change
    create_table :addresstypes do |t|
      t.string :type
      
      t.timestamps
    end
  end
end

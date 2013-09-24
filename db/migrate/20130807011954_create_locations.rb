class CreateLocations < ActiveRecord::Migration


  def up
      create_table :locations do |t|
        t.string :addressline1
        t.string :addressline2
        t.string :addressline3
        t.string :addressline4
        t.string :city
        t.references :states

        t.timestamps
    end
  end

  def down
  end

  


end

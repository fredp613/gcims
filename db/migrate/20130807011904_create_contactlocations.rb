class CreateContactlocations < ActiveRecord::Migration
  def change
    create_table :contacts_locations do |t|
      t.references :location, :index => true
      t.references :contact, :index => true
      t.timestamps
    end
  end
end

class CreateClientlocations < ActiveRecord::Migration
  def change
    create_table :clients_locations do |t|
      t.references :location, :index => true
      t.references :client, :index => true
      t.timestamps
    end
  end
end

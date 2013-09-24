class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :firstname
      t.string :lastname
      t.references :client, :index => true
      t.references :addressable, polymorphic: true
      t.timestamps
    end
  end
end

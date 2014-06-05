class CreateUserClients < ActiveRecord::Migration
  def change
    create_table :user_clients do |t|
      t.references :user, index: true
      t.references :client, index: true

      t.timestamps
    end
  end
end

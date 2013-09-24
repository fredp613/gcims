class CreateCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|
      t.string :registrationnumber
      t.datetime :registrationdate
      t.integer :client_id

      t.timestamps
    end
  end
end

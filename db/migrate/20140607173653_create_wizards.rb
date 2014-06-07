class CreateWizards < ActiveRecord::Migration
  def change
    create_table :wizards do |t|
      t.references :user, index: true

      t.timestamps
    end
  end
end

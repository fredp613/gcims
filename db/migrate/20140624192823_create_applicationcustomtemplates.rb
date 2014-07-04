class CreateApplicationcustomtemplates < ActiveRecord::Migration
  def change
    create_table :applicationcustomtemplates do |t|
      t.references :user, index: true
      t.references :application, index: true
      t.references :customtemplate, index: true

      t.timestamps
    end
  end
end

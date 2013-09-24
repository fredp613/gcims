class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.references :commitmentitem, :index => true
      t.references :project, :index => true
      t.text :desc
      t.timestamps
    end
  end
end

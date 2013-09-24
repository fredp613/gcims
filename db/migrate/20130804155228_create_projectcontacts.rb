class CreateProjectcontacts < ActiveRecord::Migration
  def change
    create_table :projectcontacts do |t|
      t.references :contacttype, :index => true
      t.references :contact, :index => true
      t.references :project, :index => true
      t.timestamps
    end
  end
end

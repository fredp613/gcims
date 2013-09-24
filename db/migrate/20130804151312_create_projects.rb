class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :projectname
      t.text :projectdesc
      t.references :client, :index => true
      t.timestamps
    end
  end
end

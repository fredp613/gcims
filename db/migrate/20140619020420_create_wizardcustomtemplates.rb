class CreateWizardcustomtemplates < ActiveRecord::Migration
  def change
    create_table :wizardcustomtemplates do |t|
      t.references :user, index: true
      t.references :customtemplate, index: true
      t.references :wizard, index: true

      t.timestamps
    end
  end
end

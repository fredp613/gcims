class Fuzzyup < ActiveRecord::Migration
  def up
  	execute "create EXTENSION fuzzystrmatch;"
  end

  def down
  end
end

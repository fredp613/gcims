class Fuzzydrop < ActiveRecord::Migration
  def up
  	execute "DROP EXTENSION fuzzystrmatch;"
  end

 
end

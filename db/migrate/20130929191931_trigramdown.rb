class Trigramdown < ActiveRecord::Migration
  def up
  	execute "drop extension pg_trgm"
  end
  
end

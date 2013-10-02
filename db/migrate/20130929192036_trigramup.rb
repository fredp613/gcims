class Trigramup < ActiveRecord::Migration
  def up
  	execute "create extension pg_trgm"
  end

 
end

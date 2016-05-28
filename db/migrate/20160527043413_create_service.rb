class CreateService < ActiveRecord::Migration
   def up
  	create_table :services do |t|
  		t.string :name
  		t.string :auth
  		t.string :description
  		t.string :url
  		t.timestamps
  	end
  end
  def down
  	drop_table :services
  end
end

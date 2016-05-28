class AddServiceActivation < ActiveRecord::Migration
  def change
  	add_column :services, :status, :string, null: true
  end
end

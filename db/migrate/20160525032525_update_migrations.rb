class UpdateMigrations < ActiveRecord::Migration
  def change
  		remove_column :documents, :type
  		add_column :documents, :kind, :string
  		add_index :documents, :name
  end
end

class AddFileLinkToDoc < ActiveRecord::Migration
  def change
  	add_column :documents, :url, :string
  	add_column :documents, :icon, :string
  end
end

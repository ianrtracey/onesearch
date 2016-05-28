class AddRelServiceDocumentsBelongs < ActiveRecord::Migration
  def change
  	add_belongs_to(:documents, :service)
  end
end

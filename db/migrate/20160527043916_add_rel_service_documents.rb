class AddRelServiceDocuments < ActiveRecord::Migration
  def change
  	add_reference(:documents, :service, index: true)
  	add_belongs_to(:documents, :service)
  end
end

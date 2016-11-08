class RenameTables < ActiveRecord::Migration[5.0]
  def change
    rename_table :files, :documents
    rename_table :file_datas, :document_data
  end
end

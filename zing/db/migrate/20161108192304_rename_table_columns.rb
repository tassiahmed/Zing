class RenameTableColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :document_data, :file_id, :document_id
  end
end

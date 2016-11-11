class AddPasswordColumnToDocument < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :password_hash, :string
  end
end

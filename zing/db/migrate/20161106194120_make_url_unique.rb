class MakeUrlUnique < ActiveRecord::Migration[5.0]
  def change
    add_index :files, :file_url, unique: true
  end
end

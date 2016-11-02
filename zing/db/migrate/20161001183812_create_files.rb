# Creates the table to store file uploads
class CreateFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :files do |t|
      t.string :filename
      t.integer :time_available
      t.boolean :file_active
      t.string :content_type
      t.string :file_url
      t.timestamps
    end
  end
end

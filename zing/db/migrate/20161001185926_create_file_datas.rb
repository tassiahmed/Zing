# Create table to store actual file data
class CreateFileDatas < ActiveRecord::Migration[5.0]
  def change
    create_table :file_datas, id: false do |t|
      t.primary_key :file_id
      t.binary :contents
    end
    add_foreign_key :file_datas, :files
  end
end

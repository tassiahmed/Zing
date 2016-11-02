class File < ActiveRecord::Base
  has_one :file_data, dependent: :destroy
end

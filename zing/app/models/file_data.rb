# Model that stores actual File contents
class FileData < ActiveRecord::Base
  belongs_to :file

  def initialize(params = {})
    super
    self.file_id = params[:file_id]
    self.contents = params[:file].read
  end
end

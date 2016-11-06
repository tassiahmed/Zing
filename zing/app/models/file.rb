class File < ActiveRecord::Base
  has_one :file_data, dependent: :destroy

  def initialize(params = {})
    @new_file = params[:file]
    super
    if @new_file
      self.filename = sanitize_filename(@new_file.original_filename)
      self.content_type = @new_file.content_type
      self.file_url = generate_file_url(@new_file)
      self.file_active = true
      self.time_available = params[:time_available]
      @file_data = FileData.new(file_id: id, file: @new_file)
    end
  end

  def available_for_download?
    file_active == true
  end

  private

  def generate_file_url(file)
    # Create a unique url for file
  end

  def sanitize_filename(filename)
    File.basename(filename)
  end
end

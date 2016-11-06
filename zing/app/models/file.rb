require 'digest/murmurhash'

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
    puts "Generating download url #{file.original_filename}"
    tmp_url = Digest::MurmurHash64a.hexdigest(file.original_filename + :id.to_s)
    inc = 1
    while File.exist?(file_url: tmp_url)
      tmp_url = Digest::MurmurHash64a.hexdigest(file.original_filename +
                                                (:id + inc).to_s)
      inc += 1
    end
    puts " -- created url: #{tmp_url}"
    tmp_url
  end

  def sanitize_filename(filename)
    File.basename(filename)
  end
end

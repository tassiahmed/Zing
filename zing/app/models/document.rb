require 'digest/murmurhash'
require 'bcrypt'

# Model for Files
class Document < ActiveRecord::Base
  include BCrypt
  attr_accessor :document_data
  has_one :document_data, dependent: :destroy
  after_commit :create_document_data

  def initialize(params = {})
    @file = params.delete(:file)
    super
    return unless @file
    self.filename = sanitize_filename(@file.original_filename)
    self.content_type = @file.content_type
    self.file_url = generate_file_url(@file)
    self.file_active = true
    self.time_available = params.delete(:time_available)
  end

  def available_for_download?
    file_active == true
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def check_password(user_input)
    password == user_input
  end

  private

  def create_document_data
    @document_data = DocumentData.new(document_id: id, file: @file)
    @document_data.save!
  end

  def generate_file_url(file)
    # puts "Generating download url #{file.original_filename}"
    inc = 1
    tmp_url = Digest::MurmurHash64A.hexdigest(file.original_filename +
                                              inc.to_s)
    until Document.where(file_url: tmp_url).empty?
      inc += 1
      tmp_url = Digest::MurmurHash64A.hexdigest(file.original_filename +
                                                inc.to_s)
    end
    # puts " -- created url: #{tmp_url}"
    tmp_url
  end

  def sanitize_filename(filename)
    File.basename(filename)
  end
end

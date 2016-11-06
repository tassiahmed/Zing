class FilesController < ActionController::Base
  def index
    @files = File.where(file_active: true)
  end

  def download
    @file = File.find(params[:id])
    return unless @file.available_for_download?
    @file_data = FileData.where(file_id: params[:id]).first
    send_data(@file_data.contents,
              type: @file.content_type,
              filename:  @file.file_name)
  end

  def new
    @file = File.new
  end

  def create
    @file = File.new(file_params)
  end

  def destroy
    @file.destroy
  end
end

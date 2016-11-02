class FilesController < ActionController::Base
  def index
    @files = File.where(file_active: true)
  end

  def download
    @file = File.find(params[:id])
    @file_data = FileData.where(file_id: params[:id]).first
    send_data @file_data.contents,
              filename: @file.file_name,
              type: @file.content_type
  end

  def new
  end

  def destroy
    @file.destroy
  end
end

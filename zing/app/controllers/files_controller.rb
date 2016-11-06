#  Controller for Files
class FilesController < ActionController::Base
  before_action :set_file, only: [:download, :edit, :destroy]

  def index
    @files = File.where(file_active: true)
  end

  def download
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

  def edit
  end

  def destroy
    @file.destroy
  end

  private

  def set_file
    @file = File.find(params[:id])
  end

  # Allow only paramters that have been whitelisted to be received
  def file_params
    params.require(:file).permit(:file, :time_available)
  end
end

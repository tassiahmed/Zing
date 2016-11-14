#  Controller for Files
class DocumentsController < ApplicationController
  before_action :set_file, only: [:download, :show, :edit, :destroy]

  def index
    @documents = Document.where(file_active: true)
  end

  def home
    @documents = Document.where(file_active: true)
  end

  def new
    @document = Document.new
  end

  def show
  end

  def create
    return unless params[:document]
    @document = Document.new(file_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to documents_path,
                      notice: "#{@document.filename} has been saved" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
  end

  def download
    return unless @document.available_for_download?
    @document_data = DocumentData.find(@document.id)
    send_data(@document_data.contents,
              type: @document.content_type,
              filename:  @document.filename)
  end

  def destroy
    @document.destroy
  end

  private

  def set_file
    @document = Document.where(file_url: params[:id]).first
  end

  # Allow only paramters that have been whitelisted to be received
  def file_params
    params.require(:document).permit(:file, :time_available)
  end
end

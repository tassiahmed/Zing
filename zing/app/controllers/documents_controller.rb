#  Controller for Files
class DocumentsController < ApplicationController
  before_action :set_file, only: [:download, :show, :edit, :destroy]

  def index
    @documents = Document.where(file_active: true)
  end

  def new
    @document = Document.new
  end

  def show
    # raise
    @password_verified = true
    @password_verified = false if @document.password != '' &&
                                  params[:password_confirmed] != true
  end

  def create
    return unless params[:document]
    unless confirm_password
      redirect_to request.referrer, flash: { notice: 'Passwords did not match' }
      return
    end

    @document = Document.new(file_params)
    @document.password = params[:document][:password]
    @document.save!
    redirect_to root_path
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

  def confirm_password
    params[:document][:password] == params[:document][:password_confirmation]
  end

  def set_file
    @document = Document.where(file_url: params[:id]).first
  end

  # Allow only paramters that have been whitelisted to be received
  def file_params
    params.require(:document).permit(:file, :time_available)
  end
end

# Model that stores actual File contents
class DocumentData < ActiveRecord::Base
  belongs_to :document
  attr_accessor :file, :document_id

  def initialize(params = {})
    return unless params
    super
    self.document_id = params.delete(:document_id)
    self.contents = params.delete(:file).read
  end
end

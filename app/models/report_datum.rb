class ReportDatum < ActiveRecord::Base
  belongs_to :college

  has_attached_file :header
  has_attached_file :document,
                    :styles => { :medium => ["1000x200>", :jpg]},
                    :processors => [:ghostscript, :thumbnail]
  has_attached_file :signature,
                    :styles => { :medium => ["1000x200>", :jpg]},
                    :processors => [:ghostscript, :thumbnail]

  validates_attachment_content_type :header, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :signature, :content_type => /\Aimage\/.*\Z/
end

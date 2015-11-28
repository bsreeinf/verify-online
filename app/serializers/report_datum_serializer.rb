class ReportDatumSerializer < ActiveModel::Serializer
  attributes :id, :header_link, :signature_link, :from_address, :to_address, :letter_title, :subject, :body
  has_one :college_id
end

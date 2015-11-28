class ReportDataController < InheritedResources::Base

  private

    def report_datum_params
      params.require(:report_datum).permit(:college_id_id, :header_link, :signature_link, :from_address, :to_address, :letter_title, :subject, :body)
    end
end


class ReportDataController < InheritedResources::Base
  before_action :logged_in_user
  before_action :set_report_datum, only: [:index, :update]

  def index
    respond_to do |format|
      format.html
      format.json {render json: @report_datum}
    end
  end

  # PATCH/PUT /report_data/1
  # PATCH/PUT /report_data/1.json
  def update
    respond_to do |format|
      if @report_datum.update(report_datum_params)
        format.html { redirect_to report_data_path}
        format.json { render :show, status: :ok, location: @report_datum }
      else
        format.html { render :edit }
        format.json { render json: @report_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  	# Use callbacks to share common setup or constraints between actions.
    def set_report_datum
      @report_datum = ReportDatum.find(current_user.college.id)
    end

    def report_datum_params
      params.require(:report_datum).permit(:college_id, :from_address, :to_address, :letter_title, :subject, :body, :designation, :header, :signature)
    end
end


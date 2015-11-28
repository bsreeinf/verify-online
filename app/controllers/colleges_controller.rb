class CollegesController < ApplicationController
  before_action :logged_in_user
  before_action :set_college, only: [:show, :edit, :update, :destroy]
  before_action :set_report, only: [:edit_report_format]

  # GET /colleges
  # GET /colleges.json
  def index

    @colleges = College.where("name LIKE ?", "#{params[:name]}%").limit(7)

  end



  # GET /colleges/1
  # GET /colleges/1.json
  def show
    respond_to do |format|
      format.html
      format.json {render json: @college}
    end

  end

  # GET /colleges/new
  def new
    @college = College.new
  end

  # GET /colleges/1/edit
  def edit
  end

  #view report template as HTML and further implement edit; this posts to edit_report_format
  def report_template
    
  end

  def edit_report_format
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'College report template was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /colleges
  # POST /colleges.json
  def create
    @college = College.new(college_params)

    respond_to do |format|
      if @college.save
        format.html { redirect_to @college, notice: 'College was successfully created.' }
        format.json { render :show, status: :created, location: @college }
      else
        format.html { render :new }
        format.json { render json: @college.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colleges/1
  # PATCH/PUT /colleges/1.json
  def update
    respond_to do |format|
      if @college.update(college_params)
        format.html { redirect_to @college, notice: 'College was successfully updated.' }
        format.json { render :show, status: :ok, location: @college }
      else
        format.html { render :edit }
        format.json { render json: @college.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colleges/1
  # DELETE /colleges/1.json
  def destroy
    @college.destroy
    respond_to do |format|
      format.html { redirect_to colleges_url, notice: 'College was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_college
      @college = College.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def college_params
      params.require(:college).permit(:user_id, :name, :address, :verification_amount)
    end

    def set_report
      @report = ReportDatum.find(params[:id])
    end

    def report_params
      params.require(:college).permit(:college_id, :header_link, :footer_link, :signature_link, :addresser, :subject, :body)
    end
end

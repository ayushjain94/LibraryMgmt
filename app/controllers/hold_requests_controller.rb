class HoldRequestsController < ApplicationController
  before_action :set_hold_request, only: [:show, :edit, :update, :destroy]

  # GET /hold_requests
  # GET /hold_requests.json
  def index
    @hold_requests = HoldRequest.all
  end

  def approve_holdrequest
    hreq_id = params[:id]
    hreq_obj = HoldRequest.where(id: hreq_id).first
    hreq_obj.is_approved = true
    hreq_obj.save
    # redirect_to('/admin_home/holdrequestapprovals')
    redirect_to books_admin_check_out_path(param_1: hreq_obj.student_id, param_2: hreq_obj.book_id)
  end

  # GET /hold_requests/1
  # GET /hold_requests/1.json
  def show
  end

  # GET /hold_requests/new
  def new
    @hold_request = HoldRequest.new
  end

  # GET /hold_requests/1/edit
  def edit
  end

  # POST /hold_requests
  # POST /hold_requests.json
  def create
    @hold_request = HoldRequest.new(hold_request_params)

    respond_to do |format|
      if @hold_request.save
        format.html { redirect_to @hold_request, notice: 'Hold request was successfully created.' }
        format.json { render :show, status: :created, location: @hold_request }
      else
        format.html { render :new }
        format.json { render json: @hold_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hold_requests/1
  # PATCH/PUT /hold_requests/1.json
  def update
    respond_to do |format|
      if @hold_request.update(hold_request_params)
        format.html { redirect_to @hold_request, notice: 'Hold request was successfully updated.' }
        format.json { render :show, status: :ok, location: @hold_request }
      else
        format.html { render :edit }
        format.json { render json: @hold_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hold_requests/1
  # DELETE /hold_requests/1.json
  def destroy
    @hold_request.destroy
    respond_to do |format|
      format.html { redirect_to hold_requests_url, notice: 'Hold request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hold_request
    @hold_request = HoldRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hold_request_params
    params.require(:hold_request).permit(:book_id, :student_id, :is_approved, :day_count)
  end
end

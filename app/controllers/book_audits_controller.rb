class BookAuditsController < ApplicationController
  before_action :set_book_audit, only: [:show, :edit, :update, :destroy]
  before_action :set_book_audit_from_book, only: :show_history

  # GET /book_audits
  # GET /book_audits.json
  def index
    @book_audits = BookAudit.all
  end

  # GET /book_audits/1
  # GET /book_audits/1.json
  def show
  end

  # GET /book_audits/new
  def new
    @book_audit = BookAudit.new
  end

  # GET /book_audits/1/edit
  def edit
  end

  # POST /book_audits
  # POST /book_audits.json
  def create
    @book_audit = BookAudit.new(book_audit_params)

    respond_to do |format|
      if @book_audit.save
        format.html { redirect_to @book_audit, notice: 'Book audit was successfully created.' }
        format.json { render :show, status: :created, location: @book_audit }
      else
        format.html { render :new }
        format.json { render json: @book_audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_audits/1
  # PATCH/PUT /book_audits/1.json
  def update
    respond_to do |format|
      if @book_audit.update(book_audit_params)
        format.html { redirect_to @book_audit, notice: 'Book audit was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_audit }
      else
        format.html { render :edit }
        format.json { render json: @book_audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_audits/1
  # DELETE /book_audits/1.json
  def destroy
    @book_audit.destroy
    respond_to do |format|
      format.html { redirect_to book_audits_url, notice: 'Book audit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_history
    # @student = Student.find_by(@book_audit.student_id)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book_audit
    @book_audit = BookAudit.find(params[:id])
  end

  def set_book_audit_from_book
    @book_audits = BookAudit.where(book_id: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_audit_params
    params.require(:book_audit).permit(:isbn, :title, :author, :is_available, :language, :publish_date, :edition, :image, :subject, :summary, :is_special, :book_id, :is_active, :issued_date, :returned_date, :student_id)
  end
end

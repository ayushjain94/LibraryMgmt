class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy, :return]

  # GET /issues
  # GET /issues.json
  def index
    if @current_user == 'librarian'
      @lid = current_librarian.library_id
      @issues = Issue.joins("INNER JOIN books ON books.id = issues.book_id WHERE books.library_id = #{@lid}")
    elsif @current_user == 'student'
      @issues = Issue.where(student_id: @current_user.id)
    else
      @issues = Issue.all
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
  end

  def show_overdue
    if @current_user == 'student'
      @lid = current_librarian.library_id
      @issues = Issue.joins("INNER JOIN books ON books.id = issues.book_id AND issues.due_date < current_date WHERE books.library_id = #{@lid}")
    else
      @issues = Issue.joins("INNER JOIN books ON books.id = issues.book_id AND issues.due_date < current_date")
    end
    render "index"
  end

  def return
    @book = Book.find(@issue.book_id)
    @book.count = @book.count + 1
    @book_audit = BookAudit.find_by book_id: @issue.book_id
    @book_audit.returned_date = Date.today

    @hreq = HoldRequest.find_by book_id: @book.id
    if @hreq.nil? or (!@hreq.nil? and @book.is_special)
      respond_to do |format|
        if @book_audit.save && @book.save && @issue.destroy
          format.html { redirect_to @issue, notice: 'Book was successfully returned.' }
          format.json { render :show, status: :created, location: @book_audit }
        else
          format.html { render student_home_path }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    else
      # redirect_to('/admin_home/holdrequestapprovals')
      redirect_to books_admin_check_out_path(param_1: @hreq.student_id, param_2: @hreq.book_id, id: @hreq.id)
    end

  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_issue
    @issue = Issue.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def issue_params
    params.require(:issue).permit(:student_id, :book_id, :issued_from, :fine, :due_date)
  end
end
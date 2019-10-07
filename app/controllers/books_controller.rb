class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :student_check_out, :bookmark]

  # GET /books
  # GET /books.json
  def index
    if current_student.nil?
      @id = ''
    else
      @id = (Student.find_by email: current_student.email).id
    end
    @books = Book.search(params[:search], @id)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def bookmark
    @bookmark = Bookmark.new
    @bookmark.book_id = @book.id
    @bookmark.student_id = (Student.find_by email: current_student.email).id

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to @book, notice: 'Book was successfully bookmarked.' }
        format.json { render :show, status: :created, location: @bookmark }
      else
        format.html { render :new }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  def unbookmark
    student_id = (Student.find_by email: current_student.email).id
    @bookmark = Bookmark.find_by(student_id: student_id, book_id: params[:id])
    @bookmark.destroy
    redirect_to books_path
  end

  def unbookmark_from_bm
    student_id = (Student.find_by email: current_student.email).id
    @bookmark = Bookmark.find_by(student_id: student_id, book_id: params[:id])
    @bookmark.destroy
    redirect_to bookmarks_path
  end

  def admin_check_out
    @hreq = HoldRequest.find(params[:id])
    @hreq.destroy
    @book = Book.find(params[:param_1])
    @student = Student.find(params[:param_2])
    check_out(@student)
  end

  def student_check_out
    student = Student.find_by email: current_student.email
    @max_books_count = DegreeToBookMapping.find(student.degree_to_book_mappings_id).book_count
    @current_count = Issue.joins(:student).where(students: {id: student.id}).count

    if @current_count >= @max_books_count || @book.is_special || @book.count.zero?
      # render(
      #     html: "<script>alert('Exceeded the maximum no. of books you can check out! We are putting a hold request for you.')</script>".html_safe,
      #     layout: 'application'
      # )

      @holdreq = HoldRequest.new
      @holdreq.book_id = @book.id
      @holdreq.student_id = student.id
      @holdreq.is_approved = false
      @holdreq.day_count = 0

      respond_to do |format|
        if @holdreq.save
          if @current_count >= @max_books_count
            format.html { redirect_to @book, notice: 'Exhausted limit for checking out books. Pending hold request registered.' }
            format.json { render :show, status: :created, location: @book }
          elsif @book.is_special
            format.html { redirect_to @book, notice: 'This book belongs to our special collection. Pending hold request registered.' }
            format.json { render :show, status: :created, location: @book }
          elsif @book.count.zero?
            format.html { redirect_to @book, notice: 'Resource currently unavailable. Pending hold request registered.' }
            format.json { render :show, status: :created, location: @book }
          else
            format.html { render :new }
            format.json { render json: @book.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      check_out(student)
    end
  end

  # POST /books/1/check_out
  def check_out(student)
    @book_audit = BookAudit.new
    @book_audit.book_id = @book.id
    @book_audit.isbn = @book.isbn
    @book_audit.title = @book.title
    @book_audit.author = @book.author
    @book_audit.is_available = @book.is_available
    @book_audit.language = @book.language
    @book_audit.publish_date = @book.publish_date
    @book_audit.edition = @book.edition
    @book_audit.image = @book.image
    @book_audit.subject = @book.subject
    @book_audit.summary = @book.summary
    @book_audit.student_id = student.id
    @book_audit.summary = @book.summary
    @book_audit.issued_date = Date.today

    @book.count = @book.count - 1

    @issue = Issue.new
    @issue.student_id = student.id
    @issue.book_id = @book.id
    @issue.issued_from = Date.today
    @issue.fine = 0
    @max_days_count = Library.find(@book.library_id).max_borrow_count
    @issue.due_date = Time.now + @max_days_count.days
    
    respond_to do |format|
      if @book_audit.save && @book.save && @issue.save
        format.html { redirect_to @book, notice: 'Book was successfully checked out.' }
        format.json { render :show, status: :created, location: @book_audit }
        AdminMailer.book_checked_out(student.email, @book_audit.title).deliver
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  
  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:search, :isbn, :title, :author, :is_available, :language, :publish_date, :edition, :image, :subject, :summary, :is_special, :is_active, :count, :library_id)
  end
end
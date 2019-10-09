class BooksController < ApplicationController
  # before_action :authenticate_student!
  before_action :set_book, only: [:show, :edit, :update, :destroy, :student_check_out, :bookmark]
  before_action :set_book_for_lib, only: [:add_to_lib, :remove_from_lib]


  # GET /books
  # GET /books.json
  def index
    @books = search(params[:search], @current_user)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # search
  def search(search, current_user)
    if current_user == 'admin'
      if search.blank?
        @books = Book.all
      else
        @l_search = search.downcase
        @books = Book.all.where("(lower(title) LIKE :search OR lower(author) LIKE :search)", search: "%#{@l_search}%")
      end
    elsif current_user == 'student'
      @id = (Student.find_by email: current_student.email).id
      @univ = Student.find(id).university
      @lib = (Library.find_by university: @univ)
      if search.blank?
        if @lib.nil?
          @books = Hash.new
        else
          @books = Book.all.where("library_id = :library", library: "#{@lib.id}")
        end
      else
        @l_search = search.downcase
        @books = Book.all.where("(lower(title) LIKE :search OR lower(author) LIKE :search) and library_id = :library", search: "%#{@l_search}%", library: "#{@lib}")
      end
    elsif current_user == 'librarian'
      @librarian = Librarian.find_by email: current_librarian.email
      @lib = Library.find(@librarian.library_id)
      if search.blank?
        @books = Book.all.where("library_id = :library", library: "#{@lib.id}")
      else
        @l_search = search.downcase
        @books = Book.all.where("library_id = :library and (lower(title) LIKE :search OR lower(author) LIKE :search)", library: "#{@lib.id}", search: "%#{@l_search}%")
      end
    elsif current_user == 'admin'
      @id = ''
    end
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

  def update_to_lib
    @books = Book.all
  end

  def add_to_lib
    # count = Book.find_by(library_id: student_id, id: @book.id)
    if @book.nil?
      book = Book.find_by(id: params[:param_1])
      @book = book.dup
      @book.count = 1
      @book.library_id = params[:param_2]
    else
      @book.count = @book.count + 1
    end
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully added to the library.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_from_lib
    @book.count = @book.count - 1
    if @book.count == 0
      respond_to do |format|
        if @book.destroy
          format.html { redirect_to @book, notice: 'Book was successfully removed from the library.' }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { render :new }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @book.save
          format.html { redirect_to @book, notice: 'Book was successfully removed from the library.' }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { render :new }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
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
    @student = Student.find(params[:param_1])
    @book = Book.find(params[:param_2])
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

  def set_book_for_lib
    @book = Book.find_by(library_id: params[:param_2], id: params[:param_1])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:search, :isbn, :title, :author, :is_available, :language, :publish_date, :edition, :image, :subject, :summary, :is_special, :is_active, :count, :library_id)
  end

end
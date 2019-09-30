class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :check_out, :bookmark]

  # GET /books
  # GET /books.json
  def index
    @books = Book.search(params[:search])
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

  def bookmark
    @bookmark = Bookmark.new
    @bookmark.book_id = @book.id
    @bookmark.student_id = 1

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

  # POST /books/1/check_out
  def check_out
    @book_audit = BookAudit.new
    @book_audit.book_id = @book.id
    @book_audit.title = @book.title
    @book_audit.author = @book.author
    @book_audit.is_available = @book.is_available
    @book_audit.language = @book.language
    @book_audit.publish_date = @book.publish_date
    @book_audit.edition = @book.edition
    @book_audit.image = @book.image
    @book_audit.subject = @book.subject
    @book_audit.summary = @book.summary
    @book_audit.student_id = 1
    @book_audit.summary = @book.summary

    respond_to do |format|
      if @book_audit.save
        format.html { redirect_to @book, notice: 'Book was successfully checked out.' }
        format.json { render :show, status: :created, location: @book_audit }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end

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

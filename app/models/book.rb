class Book < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :library

  validates :isbn, presence: true, length: {minimum: 3, maximum: 10}
  validates :title, presence: true
  validates :author, presence: true
  validates :language, presence: true
  validates :publish_date, presence: true
  validates :edition, presence: true
  validates :subject, presence: true
  validates :summary, presence: true
  validates :count, presence: true

  def self.search(search, id)
    if search.blank? && id.blank?
      @books = Book.all.where("count > 0")
    elsif search.blank?
      @univ = Student.find(id).university
      @lib = Library.find_by university: @univ
      if @lib.nil?
        @books = Hash.new
      else
        @books = Book.all.where("library_id = :library", library: "#{@lib.id}")
      end
    elsif id.blank?
      @l_search = search.downcase
      @books = Book.all.where("(lower(title) LIKE :search OR lower(author) LIKE :search) and count > 0", search: "%#{@l_search}%")
    else
      @univ = Student.find(id).university
      @lib = (Library.find_by university: @univ).id
      @l_search = search.downcase
      @books = Book.all.where("(lower(title) LIKE :search OR lower(author) LIKE :search) and library_id = :library and count > 0", search: "%#{@l_search}%", library: "#{@lib}")
    end
  end
end
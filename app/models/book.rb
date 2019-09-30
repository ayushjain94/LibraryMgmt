class Book < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :library

  def self.search(search)
    if search.blank?
      @books = Book.all
    else
      @parameter = search.downcase
      @books = Book.all.where("lower(title) LIKE :search", search: "%#{@parameter}%")
    end
  end

  validates :isbn, presence: true, length: {minimum: 3, maximum: 10}
  validates :title, presence: true
  validates :author, presence: true
  validates :language, presence: true
  validates :publish_date, presence: true
  validates :edition, presence: true
  validates :subject, presence: true
  validates :summary, presence: true
  validates :count, presence: true
end

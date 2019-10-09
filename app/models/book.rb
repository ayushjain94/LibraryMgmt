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

end
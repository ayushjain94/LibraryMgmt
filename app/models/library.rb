class Library < ApplicationRecord
  validates :name, presence: true
  validates :university, presence: true
  validates :location, presence: true
  validates :max_borrow_count, presence: true
  validates :fine, presence: true
end

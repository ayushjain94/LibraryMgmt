class Issue < ApplicationRecord
  belongs_to :student
  belongs_to :book
end

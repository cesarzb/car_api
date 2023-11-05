class Brand < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 0 }
  validates :year, presence: true, numericality: { greater_than: 0 }
end

class Car < ApplicationRecord
  belongs_to :brand

  validates :seats, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :model, presence: true, length: { minimum: 0 }
end

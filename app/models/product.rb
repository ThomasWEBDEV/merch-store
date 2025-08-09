class Product < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
end

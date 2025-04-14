class Room < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :address, presence: true

  validates :price, numericality: { greater_than: 1 }
end

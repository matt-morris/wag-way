class Owner < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude

  has_many :walks, dependent: :destroy
  has_many :walkers, -> { distinct }, through: :walks
  belongs_to :address, optional: true

  validates :latitude, presence: true, numericality: {
    greater_than_or_equal_to: -90,
    less_than_or_equal_to:     90,
  }
  validates :longitude, presence: true, numericality: {
    greater_than_or_equal_to: -180,
    less_than_or_equal_to:     180,
  }
end

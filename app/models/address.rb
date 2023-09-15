class Address < ApplicationRecord
  has_many :owners
  has_many :walkers

  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :postal_code, presence: true, format: {
    with: /\A\d{5}(-\d{4})?\z/ # we're assuming US postal codes for now
  }
  validates :country_code, presence: true, length: { is: 2 }

  validates :latitude, presence: true, numericality: {
    greater_than_or_equal_to: -90,
    less_than_or_equal_to:     90,
  }

  validates :longitude, presence: true, numericality: {
    greater_than_or_equal_to: -180,
    less_than_or_equal_to:     180,
  }
end

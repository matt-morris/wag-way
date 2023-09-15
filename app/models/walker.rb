class Walker < ApplicationRecord
  MIN_HOURLY_RATE_IN_CENTS = 2500  # should these be configurable?
  MAX_HOURLY_RATE_IN_CENTS = 15000 # are these reasonable values?

  DEFAULT_RADIUS_IN_MILES = 10
  MAX_RADIUS_IN_MILES     = 100

  reverse_geocoded_by :latitude, :longitude

  has_many :walks, dependent: :destroy
  has_many :owners, -> { distinct },  through: :walks
  has_many :availabilities, dependent: :destroy

  before_validation :set_defaults

  validates :email, presence: true, uniqueness: true, format: {
    with: URI::MailTo::EMAIL_REGEXP
  }

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :avatar_url, presence: true, format: {
    with:    URI::regexp(["http", "https"]),
    message: "Valid URL required",
  }

  validates :hourly_rate_in_cents, presence: true, numericality: {
    greater_than_or_equal_to: MIN_HOURLY_RATE_IN_CENTS,
    less_than_or_equal_to:    MAX_HOURLY_RATE_IN_CENTS,
  }

  validates :radius, presence: true, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to:    100,
  }

  validates :latitude, presence: true, numericality: {
    greater_than_or_equal_to: -90,
    less_than_or_equal_to:     90,
  }

  validates :longitude, presence: true, numericality: {
    greater_than_or_equal_to: -180,
    less_than_or_equal_to:     180,
  }

  def full_name
    [first_name, last_name].join(' ')
  end

  private

  def set_defaults
    self.hourly_rate_in_cents ||= MIN_HOURLY_RATE_IN_CENTS
    self.radius               ||= DEFAULT_RADIUS_IN_MILES
  end
end

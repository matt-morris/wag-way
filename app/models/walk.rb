class Walk < ApplicationRecord
  enum status: {
    requested:          0,
    accepted:           1,
    completed:          2,
    declined:           3,
    canceled_by_owner:  4,
    canceled_by_walker: 5,
  }

  belongs_to :owner
  belongs_to :walker

  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :start_at_is_in_the_future
  validate :end_at_is_after_start_at

  validates :latitude, presence: true,
    numericality: {
      greater_than_or_equal_to: -90,
      less_than_or_equal_to:     90,
    }
  validates :longitude, presence: true,
    numericality: {
      greater_than_or_equal_to: -180,
      less_than_or_equal_to:     180,
    }

  def duration
    (end_at - start_at) / 60
  end

  def cost_in_cents
    duration * walker.hourly_rate_in_cents / 60
  end

  scope :active, -> { where(status: [:requested, :accepted]) }
  scope :inactive, -> { where.not(status: [:requested, :accepted]) }
  scope :completed, -> { where(status: :completed) }
  scope :canceled, -> { where(status: [:canceled_by_owner, :canceled_by_walker]) }
  scope :declined, -> { where(status: :declined) }

  private

  def start_at_is_in_the_future
    return unless start_at.present?
    errors.add(:start_at, "must be in the future") if start_at <= Time.zone.now
  end

  def end_at_is_after_start_at
    return unless start_at.present? && end_at.present?

    errors.add(:end_at, "must be after start_at") if end_at <= start_at
  end
end

module WithAddress
  extend ActiveSupport::Concern

  included do
    def full_address
      <<~TEXT
      #{street_address}
      #{city}, #{state}  #{postal_code}
      TEXT
    end
  end

  class_methods do
    belongs_to :address, optional: true
  end
end

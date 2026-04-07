class Place < ApplicationRecord
  belongs_to :node

  CATEGORIES = %w[nature castle beach city viewpoint park coffee].freeze

  validates :name, presence: true
  validates :category, inclusion: { in: CATEGORIES }, allow_nil: true

  # Convenient methods - take coordinates from the associated Node
  delegate :latitude, :longitude, to: :node
end
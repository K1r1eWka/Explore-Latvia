class Node < ApplicationRecord
  has_many :outgoing_edges, class_name: "Edge", foreign_key: :from_node_id, dependent: :destroy
  has_many :incoming_edges, class_name: "Edge", foreign_key: :to_node_id, dependent: :destroy
  has_one :place

  validates :latitude, presence: true, numericality: {greater_than_or_equal_to: -90,  less_than_or_equal_to: 90}
  validates :longitude, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}

  # All neighbors nodes (where there is an outgoing edge from this node)
  def neighbors
    outgoing_edges.includes(:to_node).map(&:to_node)
  end
end

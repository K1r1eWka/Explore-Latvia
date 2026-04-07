class Edge < ApplicationRecord
  belongs_to :from_node, class_name: "Node"
  belongs_to :to_node,   class_name: "Node"

  validates :distance, presence: true, numericality: { greater_than: 0 }
  validate  :no_self_loops

  private

  def no_self_loops
    errors.add(:to_node, "can not be the same as from_node") if from_node_id == to_node_id
  end
end
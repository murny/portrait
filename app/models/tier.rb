class Tier < ApplicationRecord
  has_many :customers, dependent: :nullify

  validates :name, presence: true
  validates :quantity, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
  validates :price, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: BigDecimal('99_999_999.99')
  }
end

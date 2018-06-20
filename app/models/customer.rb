class Customer < ApplicationRecord
  has_many :users, dependent: :nullify

  validates :name, presence: true,
                   length: { in: 3..50 },
                   uniqueness: { case_sensitive: false }

  validates :active, inclusion: { in: [true, false] }
end

class Customer < ApplicationRecord
  has_many :users, dependent: :nullify
  belongs_to :tier, optional: true

  validates :name, presence: true,
                   length: { in: 3..50 },
                   uniqueness: { case_sensitive: false }

  validates :active, inclusion: { in: [true, false] }

  def usage_exceeded?
    # TODO: Should roll up users sites_count into a sum cache column on customer
    if tier.blank? || users.sum(:sites_count) >= tier.quantity
      true
    else
      false
    end
  end
end

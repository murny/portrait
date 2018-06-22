class User < ApplicationRecord

  def self.authenticate(name, password)
    User.find_by name: name, password: password
  end

  has_many :sites, dependent: :destroy
  belongs_to :customer, optional: true, counter_cache: true

  scope :by_name, ->{ order(name: :asc) }

  def to_param() name end

  validates :password, presence: true
  validates :name, uniqueness: true, format: /[a-z0-9]+/
  validates :admin, inclusion: { in: [true, false] }

end

class Site < ApplicationRecord

  enum status: %i[submitted started succeeded failed]

  belongs_to :user, counter_cache: true

  has_one_attached :image

  after_create :process!
  def process!
    started!
    handle generate_png
  end

  # Set the png located at path to the image
  def handle(path)
    File.exist?(path) ? attach(path) : failed!
  end

  def attach(path)
    image.attach io: File.open(path), filename: "#{id}.png", content_type: 'image/png'
    succeeded!
  ensure
    FileUtils.rm path
  end

  def generate_png
    node      = `which node`.chomp
    file_name = "#{id}-full.png"
    command   = "#{node} #{Rails.root}/app/javascript/puppeteer/generate_screenshot.js --url='#{url}' --fullPage=true --omitBackground=true --savePath='#{Rails.root}/tmp/' --fileName='#{file_name}'"

    system command

    return "#{Rails.root}/tmp/#{file_name}"
  end

  validates :user_id, presence: true
  validates :url, format: /\A((http|https):\/\/)*[a-z0-9_-]{1,}\.*[a-z0-9_-]{1,}\.[a-z]{2,5}(\/)?\S*\z/i
  validate  :check_customer_status, on: :create
  validate  :check_customer_usage, on: :create

  private

  def check_customer_status
    return if user.blank?
    return if user.admin? || user.customer&.active?

    errors.add(:user, :invalid_customer)
  end

  def check_customer_usage
    return if user.blank?
    return if user.admin? || !user.customer&.usage_exceeded?

    errors.add(:user, :customer_usage_exceeded)
  end
end

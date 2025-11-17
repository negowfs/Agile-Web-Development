class Product < ApplicationRecord
  has_one_attached :image
  has_many :line_items
  after_commit -> { broadcast_refresh_later_to "products" }

  validates :title, :description, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  validate :acceptable_image, if: -> { image.attached? }

  before_destroy :ensure_not_referenced_by_any_line_item

  private

  def acceptable_image
    return unless image.attached?

    acceptable_types = [ "image/gif", "image/jpeg", "image/png" ]

    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "A imagem tem que ser um arquivo GIF, JPG ou PNG")
    end
  end

  def ensure_not_referenced_by_any_line_item
    if line_items.exists?
      errors.add(:base, "Line Items present")
      throw :abort
    end
  end
end

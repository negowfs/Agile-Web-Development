require "test_helper"

class Product < ApplicationRecord
  has_one_attached :image
  has_many :line_items

  validates :title, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  validate :image_presence
  validate :acceptable_image

  private

  def image_presence
    errors.add(:image, "must be attached") unless image.attached?
  end

  def acceptable_image
    return unless image.attached?

    acceptable_types = [ "image/gif", "image/jpeg", "image/png" ]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a GIF, JPG, or PNG")
    end
  end
end

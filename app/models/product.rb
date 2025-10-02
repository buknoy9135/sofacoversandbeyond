class Product < ApplicationRecord
  has_many_attached :images

  has_many :quote_requests, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  validates :youtube_url, format: { with: /\Ahttps:\/\/(www\.)?youtube\.com\/watch\?v=\S+\z/, message: "must be a valid YouTube URL" }, allow_blank: true
end

class Product < ApplicationRecord
  has_many_attached :images

  has_many :quote_requests, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :youtube_url, format: { with: /\Ahttps:\/\/(www\.)?youtube\.com\/watch\?v=\S+\z/, message: "must be a valid YouTube URL" }, allow_blank: true

  # Resize attached images before saving
  before_save :resize_attached_images

  private

  def resize_attached_images
    return unless images.attached?

    images.each do |image|
      begin
        variant = MiniMagick::Image.read(image.download)
        variant.auto_orient
        variant.resize "800x600^"
        variant.background "black"
        variant.gravity "center"
        variant.extent "800x600"
        temp_file = Tempfile.new([ "resized", ".png" ], binmode: true)
        variant.format "png"
        variant.write(temp_file.path)
        image.attach(io: File.open(temp_file.path), filename: image.filename.base + ".png", content_type: "image/png")
        temp_file.close
        temp_file.unlink
      rescue => e
        Rails.logger.error "Image resize failed: #{e.message}"
      end
    end
  end
end

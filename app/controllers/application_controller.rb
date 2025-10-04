class ApplicationController < ActionController::Base
  before_action :prepare_meta_tags, if: -> { request.get? }

  private

  def prepare_meta_tags(options = {})
    site_name   = "Sofa Covers and Beyond"
    title       = options[:title] || "Premium Sofa Covers"
    description = options[:description] || "Shop sofa covers, curtains, bed sheets, pillow covers, and upholstery to protect and refresh your living space."
    image       = options[:image] || view_context.image_url("og-image.jpg")
    current_url = request.url

    set_meta_tags(
      site: site_name,
      title: title,
      description: description,
      keywords: %w[sofa covers curtains bed sheets pillow covers upholstery home decor],
      og: {
        title: title,
        description: description,
        type: "website",
        url: current_url,
        image: image
      }
    )
  end
end

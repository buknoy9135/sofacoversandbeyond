class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  private

  def prepare_meta_tags(options = {})
    site_name   = "Sofa Covers and Beyond"
    default_title = "Affordable Sofa Covers, Curtains & Home Decor"
    default_description = "Shop sofa covers, curtains, bed sheets, pillow covers, and upholstery to refresh and protect your living space."
    default_image = view_context.image_url("og-image.jpg") # fallback icon

    options.reverse_merge!(
      site:        site_name,
      title:       default_title,
      description: default_description,
      og: {
        title:       options[:title] || default_title,
        description: options[:description] || default_description,
        image:       default_image
      }
    )

    set_meta_tags(options)
  end
end

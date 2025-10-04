class HomeController < ApplicationController
  def index
    prepare_meta_tags(
      title: "Sofa Covers and Beyond - Home",
      description: "Shop stylish and durable sofa covers, curtains, and more to refresh your living space.",
      image: view_context.image_url("og-image.jpg")
    )
  end
end

class HomeController < ApplicationController
  def index
    prepare_meta_tags(
      title: "Sofa Covers, Curtains & Home Decor Online",
      description: "Browse stylish sofa covers, curtains, bedsheets, pillow covers, and upholstery to transform your living space."
    )
  end
end

class ProductsController < ApplicationController
  before_action :authenticate_admin!, except: [ :index, :show ]
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  layout "dashboard"

  def index
    @products = Product.all

    # meta tag
    prepare_meta_tags(
      title: "Shop Sofa Covers, Curtains & Home Decor",
      description: "Browse our full range of sofa covers, curtains, bed sheets, and more.",
      og: {
        image: view_context.image_url("og-image.jpg") # default image
      }
    )
  end

  def show
    #  meta tag
    prepare_meta_tags(
      title: @product.name,
      description: @product.description.truncate(150),
      image: @product.images.attached? ? url_for(@product.images.first) : view_context.image_url("og-image.jpg")
    )
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params.except(:images))

    if @product.save
      @product.images.attach(product_params[:images]) if product_params[:images].present?
      redirect_to @product, notice: "Product created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params.except(:images, :remove_image_ids))
      # Add new images (append, don’t replace)
      if product_params[:images].present?
        @product.images.attach(product_params[:images])
      end

      # Remove selected images
      if product_params[:remove_image_ids].present?
        product_params[:remove_image_ids].each do |image_id|
          image = @product.images.find_by(id: image_id)
          image&.purge
        end
      end

      redirect_to @product, notice: "Product updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Product #{@product.name} deleted."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :price,
      :youtube_url,
      images: [],
      remove_image_ids: []
    )
  end

  def record_not_found
    redirect_to products_path, alert: "Record does not exist."
  end
end

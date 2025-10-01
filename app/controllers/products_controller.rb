class ProductsController < ApplicationController
  before_action :authenticate_admin!, except: [ :index, :show ]
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  layout "dashboard"

  def index
    @products = Product.all
  end

  def show; end

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
end

class QuoteRequestsController < ApplicationController
  def new
    @quote_request = QuoteRequest.new
    @product = Product.find_by(id: params[:product_id]) # pre-fill if product button clicked
  end

  def create
    @quote_request = QuoteRequest.new(quote_request_params)

    if @quote_request.save
      uploaded_images = Array(params[:quote_request][:images]).reject(&:blank?)

      # Convert uploaded files to a serializable format
      images_for_mail = uploaded_images.map do |f|
        { filename: f.original_filename, content: f.read, type: f.content_type }
      end

      QuoteRequestMailer.with(
        quote_request: @quote_request,
        images: images_for_mail
      ).new_quote_request.deliver_now

      redirect_to root_path, notice: "Your request has been sent!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def quote_request_params
    params.require(:quote_request).permit(:name, :email, :contact, :message, :product_id)
  end
end

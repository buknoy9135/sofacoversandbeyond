class QuoteRequestMailer < ApplicationMailer
  def new_quote_request
    @quote_request = params[:quote_request]

    if params[:images].present?
      params[:images].each do |img|
        attachments[img[:filename]] = { mime_type: img[:type], content: img[:content] }
      end
    end

    subject_line = @quote_request.product ?
      "New Quote Request for #{@quote_request.product.name}" :
      "New General Quote Request"

    mail(
      to: [ "info@sofacoversandbeyond.com", @quote_request.email ],
      subject: subject_line
    )
  end
end

class MakeProductIdNullableInQuoteRequests < ActiveRecord::Migration[7.2]
  def change
    change_column_null :quote_requests, :product_id, true
  end
end

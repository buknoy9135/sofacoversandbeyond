class CreateQuoteRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :quote_requests do |t|
      t.string :name
      t.string :email
      t.string :contact
      t.text :message
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end

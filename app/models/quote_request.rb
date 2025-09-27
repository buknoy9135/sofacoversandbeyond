class QuoteRequest < ApplicationRecord
  belongs_to :product, optional: true

  validates :name, :email, :contact, :message, presence: true
end

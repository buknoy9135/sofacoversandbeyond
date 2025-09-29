class AddYoutubeUrlToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :youtube_url, :string
  end
end

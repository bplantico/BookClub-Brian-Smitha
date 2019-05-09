class ChangeBookDefaultUrl < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :cover_img, :string, default: "https://cdn5.vectorstock.com/i/thumb-large/67/99/sketch-silhouette-image-front-view-open-book-vector-15086799.jpg"
  end
end

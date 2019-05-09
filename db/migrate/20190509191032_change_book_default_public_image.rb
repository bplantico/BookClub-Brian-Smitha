class ChangeBookDefaultPublicImage < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :cover_img, :string, default: "/images/book_default.png"
  end
end

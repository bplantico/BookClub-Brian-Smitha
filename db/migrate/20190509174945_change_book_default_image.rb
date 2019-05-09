class ChangeBookDefaultImage < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :cover_img, :string, default: "app/assets/images/book_default.png"
  end
end

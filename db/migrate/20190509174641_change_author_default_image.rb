class ChangeAuthorDefaultImage < ActiveRecord::Migration[5.1]
  def change
    change_column :authors, :author_img, :string, default: "app/assets/images/author_default.png"
  end
end

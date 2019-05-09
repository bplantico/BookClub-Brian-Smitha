class ChangeAuthorDefaultImageUrl < ActiveRecord::Migration[5.1]
  def change
    change_column :authors, :author_img, :string, default: "https://image.shutterstock.com/image-vector/pen-mightier-than-sword-line-260nw-425446240.jpg"
  end
end

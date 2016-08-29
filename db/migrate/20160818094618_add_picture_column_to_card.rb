class AddPictureColumnToCard < ActiveRecord::Migration[5.0]
  def change
    add_attachment :cards, :picture
  end
end

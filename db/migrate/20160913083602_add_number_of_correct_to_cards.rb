class AddNumberOfCorrectToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :number_of_correct, :integer, :default => 0
  end
end

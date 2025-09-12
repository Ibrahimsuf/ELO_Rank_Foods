class CreateFoods < ActiveRecord::Migration[8.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :image_filename
      t.float :elo

      t.timestamps
    end
  end
end

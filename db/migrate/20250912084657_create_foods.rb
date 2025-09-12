class CreateFoods < ActiveRecord::Migration[8.0]
  def change
    create_table :foods do |t|
      t.timestamps
      t.column :name, :string
      t.column :filename, :file
      t.column :elo, :float
    end
  end
end

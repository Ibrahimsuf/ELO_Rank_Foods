class CreateControllers < ActiveRecord::Migration[8.0]
  def change
    create_table :controllers do |t|
      t.string :food

      t.timestamps
    end
  end
end

class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.integer :customer_id
      t.string :title
      t.string :image_id
      t.string :place
      t.text :explanation

      t.timestamps
    end
  end
end

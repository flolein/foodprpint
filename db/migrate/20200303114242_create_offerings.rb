class CreateOfferings < ActiveRecord::Migration[5.2]
  def change
    create_table :offerings do |t|
      t.references :product, foreign_key: true
      t.references :producer, foreign_key: true

      t.timestamps
    end
  end
end

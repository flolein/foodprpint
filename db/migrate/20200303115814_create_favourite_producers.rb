class CreateFavouriteProducers < ActiveRecord::Migration[5.2]
  def change
    create_table :favourite_producers do |t|
      t.references :user, foreign_key: true
      t.references :producer, foreign_key: true

      t.timestamps
    end
  end
end

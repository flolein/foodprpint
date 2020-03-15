class AddPhotoToProducers < ActiveRecord::Migration[5.2]
  def change
    add_column :producers, :photo, :string
  end
end

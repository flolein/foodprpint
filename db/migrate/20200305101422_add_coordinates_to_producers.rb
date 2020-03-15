class AddCoordinatesToProducers < ActiveRecord::Migration[5.2]
  def change
    add_column :producers, :latitude, :float
    add_column :producers, :longitude, :float
  end
end

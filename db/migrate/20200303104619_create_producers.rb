class CreateProducers < ActiveRecord::Migration[5.2]
  def change
    create_table :producers do |t|
      t.string :company_name
      t.string :owner_name
      t.string :address
      t.string :city
      t.string :street
      t.string :region
      t.text :description
      t.integer :phone_number
      t.string :website

      t.timestamps
    end
  end
end

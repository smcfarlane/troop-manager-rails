class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.text :address_text

      t.timestamps
    end
  end
end

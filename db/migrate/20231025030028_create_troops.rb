class CreateTroops < ActiveRecord::Migration[7.1]
  def change
    create_table :troops do |t|
      t.string :name
      t.integer :number
      t.integer :state, null: false, default: 0
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end

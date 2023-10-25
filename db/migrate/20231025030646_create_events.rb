class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.references :troop, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

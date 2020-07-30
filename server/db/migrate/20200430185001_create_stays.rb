class CreateStays < ActiveRecord::Migration[6.0]
  def change
    create_table :stays do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.date :start_at, null: false
      t.date :end_at
      t.references :godparent, foreign_key: { to_table: :users }
      t.integer :room_nr, default: 1

      t.timestamps
    end
  end
end

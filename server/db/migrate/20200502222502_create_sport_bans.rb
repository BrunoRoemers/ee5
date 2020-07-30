class CreateSportBans < ActiveRecord::Migration[6.0]
  def change
    create_table :sport_bans do |t|
      t.references :stay, null: false, foreign_key: true
      t.boolean :negate, null: false, default: false
      t.text :reason

      t.timestamps
    end
  end
end

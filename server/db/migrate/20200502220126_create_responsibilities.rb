class CreateResponsibilities < ActiveRecord::Migration[6.0]
  def change
    create_table :responsibilities do |t|
      t.references :responsibility_type, null: false, foreign_key: true
      t.references :stay, null: false, foreign_key: true
      t.datetime :start_at, null: false

      t.timestamps
    end
  end
end

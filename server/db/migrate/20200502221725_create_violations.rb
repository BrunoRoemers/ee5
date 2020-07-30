class CreateViolations < ActiveRecord::Migration[6.0]
  def change
    create_table :violations do |t|
      t.references :stay, null: false, foreign_key: true
      t.text :reason

      t.timestamps
    end
  end
end

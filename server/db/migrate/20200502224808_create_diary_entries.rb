class CreateDiaryEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :diary_entries do |t|
      t.references :stay, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
  end
end

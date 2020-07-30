class CreateMilestoneTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :milestone_types do |t|
      t.string :name
      t.boolean :major
      t.references :previous_milestone_type, foreign_key: { to_table: :milestone_types }

      t.timestamps
    end
  end
end

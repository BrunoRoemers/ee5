class CreateMilestones < ActiveRecord::Migration[6.0]
  def change
    create_table :milestones do |t|
      t.references :milestone_type, null: false, foreign_key: true
      t.references :stay, null: false, foreign_key: true
      t.boolean :negate, null: false, default: false
      t.text :reason

      t.timestamps
    end
  end
end

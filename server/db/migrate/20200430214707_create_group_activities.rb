class CreateGroupActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :group_activities do |t|
      t.string :title, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.integer :repeat_every, comment: 'duration (start to start) (ms) after which activity is repeated'
      t.datetime :repeat_until, comment: 'activity will not be repeated past this moment'

      t.timestamps
    end
  end
end

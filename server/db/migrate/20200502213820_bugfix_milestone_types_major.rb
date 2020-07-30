class BugfixMilestoneTypesMajor < ActiveRecord::Migration[6.0]
  def change
    change_column_null :milestone_types, :major, false
    change_column_default :milestone_types, :major, from: nil, to: false
  end
end

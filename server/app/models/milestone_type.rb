class MilestoneType < ApplicationRecord
  # NOTE: since the first milestone type does not have a previous milestone type,
  #       it is the one with previous_milestone_type_id set to NULL
  #       (only one row should have previous_milestone_type_id set to NULL)
  belongs_to :previous_milestone_type,
             class_name: 'MilestoneType',
             optional: true

  has_one :next_milestone_type,
          class_name: 'MilestoneType',
          foreign_key: 'previous_milestone_type_id',
          inverse_of: :previous_milestone_type,
          dependent: :nullify

  has_many :milestones,
           dependent: :restrict_with_error # cannot delete milestone type if it has associated milestones
end

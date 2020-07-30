class Milestone < ApplicationRecord
  belongs_to :milestone_type
  belongs_to :stay
end

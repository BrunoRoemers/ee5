class ResponsibilityType < ApplicationRecord
  has_many :responsibilities, dependent: :restrict_with_error # cannot delete responsibility type if it has associated responsibilities
end

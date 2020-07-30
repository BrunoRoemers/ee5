class Responsibility < ApplicationRecord
  belongs_to :responsibility_type
  belongs_to :stay
end

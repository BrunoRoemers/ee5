class Stay < ApplicationRecord
  belongs_to :patient, class_name: 'User'
  belongs_to :godparent, class_name: 'User', optional: true

  has_many :milestones,
           -> { order(created_at: :asc) }, # oldest first
           dependent: :restrict_with_error # cannot delete stay if it has associated milestones
  has_many :responsibilities, dependent: :restrict_with_error # cannot delete stay if it has associated responsibilities
  has_many :violations,
           -> { order(created_at: :asc) }, # oldest first
           dependent: :restrict_with_error # cannot delete stay if it has associated violations
  has_many :sport_bans,
           -> { order(created_at: :asc) }, # oldest first
           dependent: :restrict_with_error # cannot delete stay if it has associated sport bans
  has_many :doctor_appointments, dependent: :restrict_with_error # cannot delete stay if it has associated doctor appointments
  has_many :diary_entries, dependent: :restrict_with_error # cannot delete stay if it has associated diary entries

  validates :start_at, presence: true

  def completed_milestone_count
    mcount = milestones.count
    nmcount = milestones.where(negate: true).count
    mcount - 2 * nmcount
  end
end

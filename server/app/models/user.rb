class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :stays,
           foreign_key: 'patient_id',
           inverse_of: :patient,
           dependent: :restrict_with_error # cannot delete user if it has associated stays

  has_many :godchildstays,
           class_name: 'Stay',
           foreign_key: 'godparent_id',
           inverse_of: :godparent,
           dependent: :nullify # remove reference to user when deleted

  has_many :godchildren,
           through: :godchildstays,
           source: :patient

  has_many :milestones,
           through: :stays

  has_many :responsibilities,
           through: :stays

  has_many :violations,
           through: :stays

  has_many :sport_bans,
           through: :stays

  has_many :doctor_appointments,
           through: :stays

  has_many :diary_entries,
           through: :stays

  def display_name=(value)
    super(value.presence)
  end

  def birthday?
    return false if birthday.nil?

    today = Time.zone.today
    birthday.month == today.month && birthday.day == today.day
  end
end

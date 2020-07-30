class ModelController < ApplicationController
  def index
    @users = User.all
    @current_user_id = current_user&.id

    @stays = Stay.all

    @activities = GroupActivity.all

    @milestone_types = MilestoneType.all

    @milestones = Milestone.all

    @responsibility_types = ResponsibilityType.all

    @responsibilities = Responsibility.all

    @violations = Violation.all

    @sport_bans = SportBan.all

    @doctor_appointments = DoctorAppointment.all

    @diary_entries = DiaryEntry.all
  end
end

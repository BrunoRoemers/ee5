class Admin::StaysController < Admin::BaseController
  def index
    @total_milestone_count = MilestoneType.count

    @status_filter = params[:status]

    # TODO: pagination
    stays = fetch_stays(@status_filter)
    @rows = table_row_data(stays)
  end

  def new
    @select_users = user_select_options(User.all)
    @stay = Stay.new
  end

  def create
    @stay = Stay.new(create_stay_params)
    @stay.patient = User.find(params[:patient_id])

    if @stay.save
      # success
      helpers.alert success: "#{@stay.patient.full_name} is successfully enrolled in the program."
      redirect_to stays_path
    else
      # fail
      @select_users = user_select_options(User.all)
      render 'new'
    end
  end

  def edit
    @select_users = user_select_options(User.all)
    @stay = Stay.find(params[:id])
  end

  def update
    # render plain: params.inspect
    @stay = Stay.find(params[:id])

    # update
    if @stay.update(update_stay_params)
      helpers.alert success: 'Stay was successfully updated.'
      redirect_to stays_path
    else
      render 'edit'
    end
  end

  def destroy
    # render plain: params.inspect
    @stay = Stay.find(params[:id])

    if @stay.destroy
      helpers.alert success: 'Stay was successfully deleted.'
      redirect_to stays_path
    else
      render 'edit'
    end
  end

  private

  def create_stay_params
    params.require(:stay).permit(:start_at)
  end

  def update_stay_params
    params.require(:stay).permit(:start_at, :end_at)
  end

  def user_select_options(users)
    users.map do |user|
      [user.full_name, user.id]
    end
  end

  def fetch_stays(status)
    s = Stay.includes(:patient, :sport_bans, :violations).order(start_at: :asc) # eager loading

    case status
    when 'active'
      s.where(end_at: nil)
    when 'not-active'
      s.where.not(end_at: nil)
    else
      s # return all stays
    end
  end

  def table_row_data(stays) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    stays.map do |stay|
      row = {}

      # Id
      row[:id] = stay.id

      # Name
      row[:name] = stay.patient.display_name || stay.patient.full_name

      # Red card and yellow card
      vio_count = stay.violations.count
      row[:yellow_card_now] = vio_count >= 1
      row[:red_card_now] = vio_count >= 2

      # Sports ban
      row[:sport_ban_now] = false # default
      stay.sport_bans.each do |sport_ban| # asc order (see Stay model)
        row[:sport_ban_now] = !sport_ban.negate?
      end

      # Birthday
      row[:birthday] = stay.patient.birthday
      row[:birthday_now] = stay.patient.birthday?

      # Admission date
      row[:stay_start_at] = stay.start_at

      # Stay period
      row[:stay_duration] = (stay.end_at - stay.start_at).to_i unless stay.end_at.nil?

      # Milestones
      row[:completed_milestone_count] = stay.completed_milestone_count

      # return processed row
      row
    end
  end
end

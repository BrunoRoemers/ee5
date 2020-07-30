class Admin::PeopleController < Admin::BaseController
  def index
    @status_filter = params[:status]

    users = fetch_users(@status_filter)
    @rows = table_row_data(users)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)

    if @user.save
      # success
      helpers.alert success: "#{@user.full_name} was successfully created."
      redirect_to people_path
    else
      # fail
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    # render plain: params.inspect
    @user = User.find(params[:id])

    # ignore password fields when blank
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    # update
    if @user.update(update_user_params)
      helpers.alert success: 'User was successfully updated.'
      redirect_to people_path
    else
      render 'edit'
    end
  end

  def destroy
    # render plain: params.inspect
    @user = User.find(params[:id])

    if @user.destroy
      helpers.alert success: 'User was successfully deleted.'
      redirect_to people_path
    else
      render 'edit'
    end
  end

  private

  def create_user_params
    params.require(:user).permit(:full_name, :display_name, :email, :password, :password_confirmation)
  end

  def update_user_params
    params.require(:user).permit(:full_name, :display_name, :email, :password, :password_confirmation)
  end

  def fetch_users(status)
    u = User.includes(:stays)

    case status
    when 'patients'
      u.filter do |user|
        user.stays.count.positive?
      end
    when 'care-takers'
      u.filter do |user|
        !user.stays.count.positive?
      end
    else
      u # return all users
    end
  end

  def table_row_data(users) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    users.map do |user|
      row = {}

      # Id
      row[:id] = user.id

      # Role
      row[:role] = user.stays.count.positive? ? 'patient' : 'user'

      # Name
      row[:name] = user.display_name

      # Full name
      row[:full_name] = user.full_name

      # Email
      row[:email] = user.email

      # Return
      row
    end
  end
end

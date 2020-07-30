# frozen_string_literal: true

module AlertHelper
  def alerts # rubocop:disable Metrics/AbcSize
    alerts = []

    # show Devise messages
    alerts += parse_alert_input error: flash[:alert] if flash.key? :alert
    alerts += parse_alert_input success: flash[:notice] if flash.key? :notice

    # show regular messages
    alerts += flash[:alerts] if flash.key? :alerts

    # return
    alerts
  end

  def alert_class(type)
    case type
    when 'error'
      'alert-error bg-red-600'
    when 'success'
      'alert-success bg-green-500'
    else
      'alert-info bg-blue-500'
    end
  end

  # Usage: alert 'info message'
  #        alert error: 'error message',
  #              success: 'success message',
  #              info: 'info message'
  def alert(input)
    # make sure :alerts flash exists
    flash[:alerts] ||= []

    # add new alerts
    flash[:alerts] += parse_alert_input(input)
  end

  # Usage: see alert
  def alert_now(input)
    # make sure :alerts flash exists
    flash.now[:alerts] ||= []

    # add new alerts
    flash.now[:alerts] += parse_alert_input(input)
  end

  private

  def parse_alert_input(input)
    alerts = []

    if input.is_a? Hash
      input.each do |type, msg|
        alerts.push 'type' => type.to_s, 'message' => msg
      end
    else
      alerts.push 'type' => 'info', 'message' => input
    end

    # return
    alerts
  end
end

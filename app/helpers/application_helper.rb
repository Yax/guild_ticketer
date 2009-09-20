# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def event_time(time)
    case time
    when 24.hours.ago..Time.now
      time.strftime('%H:%M')
    else
      time.strftime('%d.%m')
    end
  end

  def event_date(date)
    l date, :format => :long
  end
end

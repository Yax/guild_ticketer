module TicketsHelper

  def simplify_basic_state(state)
    case state
    when 'pending'
      'orange'
    when 'opened'
      'green'
    when 'closed'
      'red'
    else
      'WTF?'
    end
  end

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

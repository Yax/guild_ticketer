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
      time.hour.to_s + ':' + time.min.to_s
    else
      time.strftime('%d.%m')
    end
  end
  

end

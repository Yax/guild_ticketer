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

end

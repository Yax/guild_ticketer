module TicketsHelper

  def simplify_basic_state(state)
    case state
    when 'pending'
      'Ocz'
    when 'opened'
      'Otw'
    when 'closed'
      'Zam'
    else
      'WTF?'
    end
  end

end

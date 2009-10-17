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

  def label(object_name, method, text = nil, options = {})
    text ||= object_name.classify.constantize.human_attribute_name(method.to_s).capitalize
    ActionView::Helpers::InstanceTag.new(object_name, method, self,
      options.delete(:object)).to_label_tag(text, options)
  end

  def sm_select(state_events,current_state)
    arr = [[sm_t(current_state),'']]
    state_events.map { |s| arr << [sm_t(s.to), s.event] }
    arr
  end

  def sm_t(state)
    t 'state_machine.'+state
  end

  def sm_ts(state)
    t 'state_machine.plural.'+state
  end
  
end

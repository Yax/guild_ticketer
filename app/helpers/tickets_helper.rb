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

  def category_name(category, len)
    unless category.nil?
      truncate(category.name, :length => len)
    else
      "Błędna kategoria!"
    end 
  end

  def page_entries_info(collection, options = {})
    entry_name = options[:entry_name] ||
      (collection.empty?? 'entry' : collection.first.class.name.underscore.sub('_', ' '))

    if collection.total_pages < 2
      case collection.size
      when 0; "Nie znaleziono zgłoszenia"
      when 1; "Wyświetlam <b>1</b> #{p_format_count(1,"zgłoszenie","zgłoszenia","zgłoszeń")}"
      else;   "Wyświetlam <b>wszystkie #{collection.size}</b> #{p_format_count(collection.size,"zgłoszenie","zgłoszenia","zgłoszeń")}"
      end
    else
      %{Wyświetlam <b>%d&nbsp;-&nbsp;%d</b> z <b>%d</b>  #{p_format_count(collection.total_entries,"zgłoszenie","zgłoszenia","zgłoszeń")}}% [
        collection.offset + 1,
        collection.offset + collection.length,
        collection.total_entries
      ]
    end
  end

  def p_format_count(nr, f1, f2, f3)
    #strona, strony, stron

    nr = nr.to_i

    if nr == 1
      return f1
    end

    nr = nr % 100
    if nr > 10 and nr < 20
      return f3
    end

    nr = nr % 10 #tylko reszta

    if (nr > 1 && nr < 5)
      return f2
    else
      return f3
    end
  end

end

namespace :db do
  desc 'Erase and fill database with dev data'
  task :populate => :environment do
    require 'populator'
    require 'faker'

    [Ticket, Complaint, Message].each(&:delete_all)
    
    categories = Array.new
    hcategories = Hash.new
    tcategories = TicketCategory.all
    tcategories.map { |cat| categories << cat.to_param }
    tcategories.map { |cat| hcategories[cat.to_param] = cat.ticket_type }

    Ticket.populate 100 do |ticket|
      ticket.ticket_category_id = categories
      ticket.employee_name = ["Andrzej Iksiński", "Paweł Kwiat", "Tomasz Łodyga"]
      ticket.order_number = 10000..99999
      ticket.email = Faker::Internet.email
      ticket.basic_state = ["pending", "opened", "closed"]
      ticket.basic_state_order = case ticket.basic_state
                             when 'pending' then 1
                             when 'opened' then 2
                             when 'closed' then 3
                             else 0
                             end
      ticket.type = hcategories[ticket.ticket_category_id]
      ticket.state = 'pending' unless ticket.type == 'Ticket'
      ticket.created_at = 5.months.ago..Time.now
      ticket.created_at -= Time.now.utc_offset
      Message.populate 3..6 do |message|
        message.ticket_id = ticket.id
        message.created_at = ticket.created_at..Time.now
        message.created_at -= Time.now.utc_offset
        message.from = [ticket.employee_name, ticket.email]
        message.from_client = message.from == ticket.email ? true : false
        message.content = Populator.sentences(3..7)
      end
    end

    Ticket.all.each do |ticket|
      ticket.update_last_message
    end
  end
=begin
  desc 'Erase and fill database with smaller dev data'
  task :populate_small => :environment do
    require 'populator'
    require 'faker'

    [TicketCategory, Ticket, Complaint, Message].each(&:delete_all)

    availability = TicketCategory.create(:name => "Pytanie o dostępność", :ticket_type => "Ticket")
    book_return = TicketCategory.create(:name => "Zwrot książki", :ticket_type => "Ticket")
    shipment = TicketCategory.create(:name => "Wysyłka", :ticket_type => "Ticket")
    complaint = TicketCategory.create(:name => "Reklamacja", :ticket_type => "Complaint")

    Ticket.populate 30 do |ticket|
      ticket.ticket_category_id = [availability.id, book_return.id, shipment.id]
      ticket.employee_name = ["Andrzej Iksiński", "Paweł Kwiat", "Tomasz Łodyga"]
      ticket.order_number = 10000..99999
      ticket.email = Faker::Internet.email
      ticket.basic_state = ["pending", "opened", "closed"]
      ticket.basic_state_order = case ticket.basic_state
                             when 'pending' then 1
                             when 'opened' then 2
                             when 'closed' then 3
                             else 0
                             end
      ticket.type = "Ticket"
      ticket.created_at = 5.months.ago..Time.zone.now
      ticket.created_at -= Time.now.utc_offset
      Message.populate 1..3 do |message|
        message.ticket_id = ticket.id
        message.created_at = ticket.created_at..Time.zone.now
        message.created_at -= Time.now.utc_offset
        message.from = [ticket.employee_name, ticket.employee_name, ticket.email]
        message.from_client = message.from == ticket.email ? true : false
        message.content = Populator.sentences(3..7)
      end
    end

    Complaint.populate 10 do |ticket|
      ticket.ticket_category_id = complaint.id
      ticket.employee_name = ["Andrzej Iksiński", "Paweł Kwiat", "Tomasz Łodyga"]
      ticket.order_number = 10000..99999
      ticket.email = Faker::Internet.email
      ticket.basic_state = ["pending", "opened", "closed"]
      ticket.basic_state_order = case ticket.basic_state
                             when 'pending' then 1
                             when 'opened' then 2
                             when 'closed' then 3
                             else 0
                             end
      ticket.type = "Complaint"
      ticket.state = ["pending", "in_question", "accepted", "declined"]
      ticket.subject = Populator.words(4..10).capitalize
      ticket.created_at = 5.months.ago..Time.zone.now
      ticket.created_at -= Time.now.utc_offset
      if (ticket.state == "declined") || (ticket.state == "accepted")
        ticket.explanation = Populator.sentences(1..4)
      end
      Message.populate 1..3 do |message|
        message.ticket_id = ticket.id
        message.created_at = ticket.created_at..Time.zone.now
        message.created_at -= Time.now.utc_offset
        message.from = [ticket.employee_name, ticket.employee_name, ticket.email]
        message.from_client = message.from == ticket.email ? true : false
        message.content = Populator.sentences(3..7)
      end
    end

    Ticket.all.each do |ticket|
      ticket.last_message_id = ticket.messages.last.id
      ticket.save
    end

  end
=end
end





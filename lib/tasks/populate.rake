namespace :db do
  desc 'Erase and fill database with dev data'
  task :populate => :environment do
    require 'populator'
    require 'faker'

    [Category, Ticket, Complaint, Message].each(&:delete_all)

    availability = Category.create(:name => "Pytanie o dostępność", :ticket_type => "Ticket")
    book_return = Category.create(:name => "Zwrot książki", :ticket_type => "Ticket")
    shipment = Category.create(:name => "Wysyłka", :ticket_type => "Ticket")
    complaint = Category.create(:name => "Reklamacja", :ticket_type => "Complaint")

    Ticket.populate 100 do |ticket|
      ticket.category_id = [availability.id, book_return.id, shipment.id]
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
      ticket.created_at = 5.months.ago..Time.now
      Message.populate 1..10 do |message|
        message.ticket_id = ticket.id
        message.created_at = ticket.created_at..Time.now
        message.from = ["klient", "sklep"]
        message.content = Populator.sentences(3..7)
      end
    end

    Complaint.populate 30 do |ticket|
      ticket.category_id = complaint.id
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
      ticket.created_at = 5.months.ago..Time.now
      if (ticket.state == "declined") || (ticket.state == "accepted")
        ticket.explanation = Populator.sentences(1..4)
      end
      Message.populate 1..10 do |message|
        message.ticket_id = ticket.id
        message.created_at = ticket.created_at..Time.now
        message.from = ["klient", "sklep"]
        message.content = Populator.sentences(3..7)
      end
    end
  end
  desc 'Erase and fill database with smaller dev data'
  task :populate_small => :environment do
    require 'populator'
    require 'faker'

    [Category, Ticket, Complaint, Message].each(&:delete_all)

    availability = Category.create(:name => "Pytanie o dostępność", :ticket_type => "Ticket")
    book_return = Category.create(:name => "Zwrot książki", :ticket_type => "Ticket")
    shipment = Category.create(:name => "Wysyłka", :ticket_type => "Ticket")
    complaint = Category.create(:name => "Reklamacja", :ticket_type => "Complaint")

    Ticket.populate 30 do |ticket|
      ticket.category_id = [availability.id, book_return.id, shipment.id]
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
      ticket.created_at = 5.months.ago..Time.now
      Message.populate 1..3 do |message|
        message.ticket_id = ticket.id
        message.created_at = ticket.created_at..Time.now
        message.from = ["klient", "sklep"]
        message.content = Populator.sentences(3..7)
      end
    end

    Complaint.populate 10 do |ticket|
      ticket.category_id = complaint.id
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
      ticket.created_at = 5.months.ago..Time.now
      if (ticket.state == "declined") || (ticket.state == "accepted")
        ticket.explanation = Populator.sentences(1..4)
      end
      Message.populate 1..3 do |message|
        message.ticket_id = ticket.id
        message.created_at = ticket.created_at..Time.now
        message.from = ["klient", "sklep"]
        message.content = Populator.sentences(3..7)
      end
    end
  end
end





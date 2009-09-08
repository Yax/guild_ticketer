class AddStatesToDevData < ActiveRecord::Migration
  def self.up
    Ticket.reset_column_information
    Ticket.update_all("basic_state = 'opened'", "employee_name LIKE 'Tomek'")
    Ticket.update_all("basic_state = 'closed'", "employee_name LIKE 'Adiego'")
  end

  def self.down
    Ticket.update_all("basic_state = NULL", "employee_name LIKE 'Tomek'")
    Ticket.update_all("basic_state = NULL", "employee_name LIKE 'Adiego'")
  end

  end

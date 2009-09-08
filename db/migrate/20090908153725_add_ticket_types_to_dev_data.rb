class AddTicketTypesToDevData < ActiveRecord::Migration
  def self.up
    Category.reset_column_information
    Ticket.reset_column_information
    Category.all.each { |cat| cat.update_attribute :ticket_type, "ticket" }
    Ticket.all.each { |t| t.update_attribute :type, "Ticket" }
  end
 
  def self.down
    Ticket.all.each { |t| t.update_attribute :type, NULL }
    Category.all.each { |cat| cat.update_attribute :ticket_type, NULL }
  end
end

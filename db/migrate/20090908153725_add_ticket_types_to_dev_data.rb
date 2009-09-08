class AddTicketTypesToDevData < ActiveRecord::Migration
  def self.up
    Category.reset_column_information
    Category.all.each { |cat| cat.update_attribute :ticket_type, "ticket" }
  end
 
  def self.down
    Category.all.each { |cat| cat.update_attribute :ticket_type, NULL }
  end
end

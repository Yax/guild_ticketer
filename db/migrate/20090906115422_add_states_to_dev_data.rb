class AddStatesToDevData < ActiveRecord::Migration
  def self.up
    execute "UPDATE `tickets` SET `basic_state` = 'opened' WHERE `id` = #{Ticket.find_by_employee_name("Tomek").id}"
    execute "UPDATE `tickets` SET `basic_state` = 'closed' WHERE `id` = #{Ticket.find_by_employee_name("Adiego").id}"
  end

  def self.down
    execute "UPDATE `tickets` SET `basic_state` = NULL WHERE `id` = #{Ticket.find_by_employee_name("Tomek").id}"
    execute "UPDATE `tickets` SET `basic_state` = NULL WHERE `id` = #{Ticket.find_by_employee_name("Adiego").id}"
  end
end

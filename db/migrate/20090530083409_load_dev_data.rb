require 'active_record/fixtures'

class LoadDevData < ActiveRecord::Migration
  def self.up
    directory = File.join(File.dirname(__FILE__), "dev_data")
    Fixtures.create_fixtures(directory, "tickets")
    Fixtures.create_fixtures(directory, "messages")
  end

  def self.down
    Ticket.delete_all
    Message.delete_all
  end
end

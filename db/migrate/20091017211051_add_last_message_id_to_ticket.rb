class AddLastMessageIdToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :last_message_id, :integer
  end

  def self.down
    remove_column :tickets, :last_message_id
  end
end

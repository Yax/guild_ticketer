class AddBasicStateOrderToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :basic_state_order, :integer
  end

  def self.down
    remove_column :tickets, :basic_state_order
  end
end

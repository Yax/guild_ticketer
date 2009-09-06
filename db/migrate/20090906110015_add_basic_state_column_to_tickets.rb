class AddBasicStateColumnToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :basic_state, :string
  end

  def self.down
    remove_column :tickets, :basic_state, :string
  end
end

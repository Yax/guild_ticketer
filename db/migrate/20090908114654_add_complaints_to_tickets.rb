class AddComplaintsToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :type, :string
    add_column :tickets, :state, :string
    add_column :tickets, :subject, :string
    add_column :tickets, :explanation, :text
  end

  def self.down
    remove_column :tickets, :explanation
    remove_column :tickets, :subject
    remove_column :tickets, :state
    remove_column :tickets, :type
  end
end

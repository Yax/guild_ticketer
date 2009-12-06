class ModifyAdditionalTicketFields < ActiveRecord::Migration
  def self.up
    remove_column :tickets, :subject
    remove_column :tickets, :explanation
    add_column :tickets, :reason, :text
  end

  def self.down
    remove_column :tickets, :reason
    add_column :tickets, :explanation, :text
    add_column :tickets, :subject, :string
  end
end

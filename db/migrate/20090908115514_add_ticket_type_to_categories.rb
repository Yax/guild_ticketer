class AddTicketTypeToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :ticket_type, :string
  end

  def self.down
    remove_column :categories, :ticket_type
  end
end

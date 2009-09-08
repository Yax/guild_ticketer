class AddTicketTypeToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :ticket_type, :string
    Category.reset_column_information
    Category.all.each { |cat| cat.update_attribute :ticket_type, "ticket" }
  end

  def self.down
    remove_column :categories, :ticket_type
  end
end

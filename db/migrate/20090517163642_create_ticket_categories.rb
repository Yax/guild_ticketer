class CreateTicketCategories < ActiveRecord::Migration
  def self.up
    create_table :ticket_categories do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_categories
  end
end

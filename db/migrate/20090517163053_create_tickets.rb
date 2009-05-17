class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.integer :category_id
      t.string :employee_name
      t.integer :order_number
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end

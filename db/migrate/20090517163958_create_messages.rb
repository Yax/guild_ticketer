class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :ticket_id
      t.text :content
      t.string :from

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end

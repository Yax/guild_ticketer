class AddFromClientToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :from_client, :boolean
  end

  def self.down
    remove_column :messages, :from_client
  end
end

class Message < ActiveRecord::Base
   # t.integer :ticket_id
   # t.text :content
   # t.string :from

  belongs_to :ticket

  validates_presence_of :from, :content
  validates_associated :ticket

end

class Message < ActiveRecord::Base
   # t.integer :ticket_id
   # t.text :content
   # t.string :from

  belongs_to :ticket
  default_scope :order => 'created_at DESC'
  
  validates_associated :ticket
  validates_presence_of :from, :content, :ticket
  
end

class Message < ActiveRecord::Base
   # t.integer :ticket_id
   # t.text :content
   # t.string :from

  belongs_to :ticket
  default_scope :order => 'created_at ASC'

  attr_protected :ticket_id
  
  validates_associated :ticket
  validates_presence_of :from, :content, :ticket
  
  before_save :set_from_client
  after_save :set_last_message

  def set_from_client
    if self.from =~ /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/
      self.from_client = true
    else
      self.from_client = false
    end
    true
  end

  def set_last_message
    ticket = self.ticket
    ticket.last_message_id = self.id
    ticket.save
  end

end

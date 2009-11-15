class Message < ActiveRecord::Base
   # t.integer :ticket_id
   # t.text :content
   # t.string :from
   # t.boolean :from_client

  belongs_to :ticket
  default_scope :order => 'created_at ASC'

  attr_protected :ticket_id
  
  validates_associated :ticket
  validates_presence_of :from, :content#, :ticket
  
  before_create :add_footer
  before_save :set_from_client
  after_save :set_last_message
  before_destroy :can_destroy?
  after_destroy :set_tickets_last_message

  private
  def add_footer
    unless self.from_client
      self.content += <<FOOTER

--
#{self.from}
#{FOOTER}
FOOTER
    end
    true
  end

  def set_from_client
    if self.from =~ /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/
      self.from_client = true
    else
      self.from_client = false
    end
    true
  end

  def set_last_message
    logger.info  self.ticket.inspect
    ticket = self.ticket
    ticket.last_message_id = self.id
    ticket.save
  end

  def set_tickets_last_message
    self.ticket.update_last_message
  end

  def can_destroy?
    self.ticket.messages.count > 1
  end

end

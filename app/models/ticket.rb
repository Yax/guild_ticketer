class Ticket < ActiveRecord::Base
  # t.integer :ticket_category_id
  # t.string :employee_name
  # t.integer :order_number
  # t.string :email
  # t.string :basic_state
  # t.string :basic_state_order
  # ---
  # t.string :type

  named_scope :pending, :conditions => { :basic_state => 'pending' }
  named_scope :opened, :conditions => { :basic_state => 'opened' }
  named_scope :closed, :conditions => { :basic_state => 'closed' }
  
  attr_protected :ticket_category_id, :type

  belongs_to :ticket_category
  has_many :messages, :dependent => :destroy
  belongs_to :last_message, :class_name => 'Message', :foreign_key => "last_message_id"

  accepts_nested_attributes_for :messages

  before_validation :set_type
  before_save :set_basic_state_order

  validates_associated :ticket_category
  validates_presence_of :email, :employee_name, :basic_state
  validates_inclusion_of :type, :in => TICKET_TYPES
  validates_format_of :email,
                      :with     => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/

  state_machine :basic_state, :initial => :pending do
    event :open do
      transition :pending => :opened
    end
    event :close do
      transition :opened => :closed
    end
    event :reopen do
      transition :closed => :opened
    end
  end

  def update_last_message
    self.last_message_id = self.messages.last.id
    self.save
  end

  private
  def validate
    errors.add(:ticket_category_id, "is not a valid ticket_category") if self.ticket_category.nil?
  end

  def set_type
    if self[:type].blank? && !self.ticket_category.nil?
      self[:type] = self.ticket_category.ticket_type
    end
  end

  def set_basic_state_order
    self.basic_state_order = case self.basic_state
                             when 'pending' then 1
                             when 'opened' then 2
                             when 'closed' then 3
                             else 0
                             end
  end

end

class Ticket < ActiveRecord::Base
  # t.integer :category_id
  # t.string :employee_name
  # t.integer :order_number
  # t.string :email
  # t.string :basic_state
  # t.string :type
  
  before_validation :set_type

  belongs_to :category
  has_many :messages, :dependent => :destroy

  validates_associated :category
  validates_presence_of :email, :employee_name, :basic_state
  validates_inclusion_of :type, :in => TICKET_TYPES
  validates_format_of :email,
                      :with     => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})/

  def validate
    errors.add(:category_id, "is not a valid category") if self.category.nil?
  end

  def set_type
    self[:type] = "Ticket" if self[:type].nil?
  end

  state_machine :basic_state, :initial => :pending do
    event :open do
      transition :pending => :opened
    end
    event :close do
      transition :opened => :closed
    end
  end

end

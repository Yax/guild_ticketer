class Question < Ticket
  # t.integer :ticket_category_id
  # t.string :employee_name
  # t.integer :order_number
  # t.string :email
  # t.string :basic_state
  # t.string :basic_state_order
  # ---
  # t.string :type
  # ---
  # t.string :state

  validates_presence_of :state

  state_machine :state, :initial => :pending do
    event :open do
      transition :pending => :being_answered
    end
    event :answer do
      transition :being_answered => :answered
    end
  end

end

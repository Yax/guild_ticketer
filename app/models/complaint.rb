class Complaint < Ticket
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
  # t.string :subject
  # t.text :explanation

  #validates_presence_of :subject
  validates_presence_of :state

  state_machine :state, :initial => :pending do

    event :investigate do
      transition :pending => :in_question
    end
    event :accept do
      transition :in_question => :accepted
    end
    event :decline do
      transition :in_question => :declined
    end

    state :declined do
      validates_presence_of :explanation
    end
  end
end

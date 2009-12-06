class Refund < Ticket
  validates_presence_of :state
  
  state_machine :state, :initial => :pending do
    event :open do
      transition :pending => :being_answered
    end
    event :answer do
      transition :being_answered => :answered
    end
    event :posted do
      transition :pending => :product_sent_back
    end
    event :receive do
      transition :product_sent_back => :product_received
    end
    event :not_receive do
      transition :product_sent_back => :product_not_received
    end

    state :product_not_received do
      validates_presence_of :reason
    end
  end
end

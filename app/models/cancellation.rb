class Cancellation < Ticket
  validates_presence_of :state
  state_machine :state, :initial => :pending do
    event :open do
      transition :pending => :during_cancellation
    end
    event :cancel do
      transition :during_cancellation => :canceled
    end
    event :not_cancel do
      transition :during_cancellation => :not_canceled
    end

    state :not_canceled do
      validates_presence_of :reason
    end
  end
end

class Technical < Ticket
  validates_presence_of :state
  state_machine :state, :initial => :pending do
    event :forward do
      transition :pending => :forwarded
    end
    event :solve do
      transition :forwarded => :solved
    end
    event :not_solve do
      transition :forwarded => :not_solved
    end
    
    state :not_solved do
      validates_presence_of :reason
    end
  end
end

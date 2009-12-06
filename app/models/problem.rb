class Problem < Ticket
  validates_presence_of :state

  state_machine :state, :initial => :pending do
    event :open do
      transition :pending => :during_solving
    end
    event :solve do
      transition :during_solving => :solved
    end
    event :not_solve do
      transition :during_solving => :not_solved
    end

    state :not_solved do
      validates_presence_of :reason
    end
  end
end

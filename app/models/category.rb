class Category < ActiveRecord::Base
  # t.string :name
  # t.string :ticket_type

  before_destroy :check_tickets

  has_many :tickets
  validates_presence_of :name, :ticket_type
  validates_uniqueness_of :name
  validates_length_of :name, :minimum => 3
  validates_inclusion_of :ticket_type, :in => TICKET_TYPES

  def check_tickets
    unless self.tickets.empty?
      errors.add_to_base('Cannot destroy category with associated tickets.')
      false
    end
  end

end

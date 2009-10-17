require 'test_helper'

class TicketCategoryTest < ActiveSupport::TestCase

  should_have_many :tickets
  should_validate_presence_of :name
  should_validate_uniqueness_of :name
  should_ensure_length_at_least :name, 3
  should_not_allow_values_for :ticket_type, 'ticket', 'uazaaa'
  TICKET_TYPES.each do |type|
    should_allow_values_for :ticket_type, type
  end
  
  should 'not allow destroying not empty ticket_categories' do
    category = ticket_categories(:zwrot)
    ticket = tickets(:zwrot_tomka)
    ticket.ticket_category_id = nil
    category.tickets << ticket
    assert !category.destroy
  end

  should 'allow destroying empty ticket_categories' do
    category = ticket_categories(:zwrot)
    category.tickets.destroy_all
    assert category.destroy
  end

end

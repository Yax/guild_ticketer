require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  should_belong_to :category
  should_have_many :messages

  should_validate_presence_of :email, :employee_name
  should_validate_presence_of :category_id, :message => "is not a valid category"
  
  should_not_allow_values_for :email, "wrong mail", "wron#g.pl"
  should_allow_values_for :email, "correct@mail.com", "weird-mailo.user@as.tv"

  should "have valid category" do
    wrong_ticket = tickets(:bledny_ticket)
    assert !wrong_ticket.valid?
    assert wrong_ticket.errors.invalid?(:category_id)
  end

end

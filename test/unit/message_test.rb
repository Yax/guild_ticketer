require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  should_belong_to :ticket
  should_validate_presence_of :from, :content#, :ticket

end

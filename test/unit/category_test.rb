require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  should_have_many :tickets
  should_validate_presence_of :name
  should_validate_uniqueness_of :name
  should_ensure_length_at_least :name, 3

end

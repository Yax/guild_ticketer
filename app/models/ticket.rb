class Ticket < ActiveRecord::Base
  belongs_to :category
  has_many: :messages
end

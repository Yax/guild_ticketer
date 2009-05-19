class Ticket < ActiveRecord::Base
  # t.integer :category_id
  # t.string :employee_name
  # t.integer :order_number
  # t.string :email
  
  belongs_to :category
  has_many: :messages
end

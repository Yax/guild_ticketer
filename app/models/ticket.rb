class Ticket < ActiveRecord::Base
  # t.integer :category_id
  # t.string :employee_name
  # t.integer :order_number
  # t.string :email
  
  belongs_to :category
  has_many :messages

  validates_associated :category
  validates_presence_of :email, :employee_name
  validates_format_of :email,
                      :with     => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})/

end

class Category < ActiveRecord::Base
  # t.string :name
  # t.string :ticket_type

  has_many :tickets
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :minimum => 3
end

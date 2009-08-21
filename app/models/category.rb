class Category < ActiveRecord::Base
  # t.string :name

  has_many :tickets
  validates_uniqueness_of :name
end

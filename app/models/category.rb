class Category < ActiveRecord::Base
  # t.string :name

  has_many :tickets
end

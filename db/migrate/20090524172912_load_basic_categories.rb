require 'active_record/fixtures'

class LoadBasicCategories < ActiveRecord::Migration
  def self.up
    directory = File.join(File.dirname(__FILE__), "dev_data")
    Fixtures.create_fixtures(directory, "categories")
  end

  def self.down
    Category.delete_all
  end
end

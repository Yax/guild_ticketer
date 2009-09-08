class AddComplaintTicketToDevData < ActiveRecord::Migration
  def self.up
    category = Category.new("name" => "Reklamacja", "ticket_type" => "Complaint");
    category.save
    complaint = Complaint.new("category_id" => Category.find_by_name("Reklamacja").to_param, "employee_name"=>"Dave", "order_number"=>"3214", "email"=>"asd@asd.pl")
    complaint.save
  end

  def self.down
    complaint = Complaint.find_by_employee_name("Dave")
    complaint.destroy
    category = Category.find_by_name("Reklamacja")
    category.destroy
  end
end

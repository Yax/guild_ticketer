# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
#

ticket_categories = { 'Pytanie o dostępność' => 'Question',
                      'Wysyłka produktu' => 'Question',
                      'Spóźniająca się wysyłka' => 'Problem',
                      'Pytanie o promocję' => 'Problem',
                      'Reklamacja produktu' => 'Complaint',
                      'Zwrot produktu' => 'Refund',
                      'Anulowanie zamówienia' => 'Cancellation',
                      'Opóźniająca się realizacja' => 'Problem',
                      'Pytanie o fakturę VAT' => 'Question',
                      'Problem z fakturą VAT' => 'Problem',
                      'Problem z opłatą zamówienia' => 'Problem',
                      'Problem techniczny' => 'Technical',
                      'Inny problem' => 'Problem' }

ticket_categories.each_pair do |name,type|
  TicketCategory.create(:name => name, :ticket_type => type)
end

# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

TICKET_TYPES = %w{ Ticket Question Problem Complaint Refund Cancellation Technical }

FOOTER = <<FOOT
DZIAŁ OBSLUGI KLIENTA
www.sklep.gildia.pl
ZAKUPY W INNYM WYMIARZE

Dane telekontaktowe:

Sklep.gildia.pl
Kolejowa 15/17
01-217 Warszawa
pokój 109, I piętro

tel. stacjonarny: 022 632 01 99
komórka: 609 313 500
e-mail: sklep@gildia.pl

Pracujemy codziennie w godz. 10-16
W tych godzinach również odpowiadamy na Państwa pytania.

-----------------------------------

Gildia Internet Services Sp. z o.o.
Grottgera 9A/7 | 00-785 Warszawa
NIP: 521-335-94-08 | REGON: 140228281
Kapitał zakładowy: 50.000 PLN

Spółka zarejestrowana w Sądzie Rejonowym m.st. Warszawy
XIII Wydział Gospodarczy Krajowego Rejestru Sądowego
pod numerem KRS: 0000239271
FOOT

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem 'thoughtbot-shoulda', :lib => 'shoulda'
  config.gem 'pluginaweek-state_machine', :lib => 'state_machine'
  config.gem 'mislav-will_paginate', :version => '~> 2.3.11', :lib => 'will_paginate'
  config.gem 'searchlogic'
  
  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'Warsaw'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  config.i18n.default_locale = :pl
end

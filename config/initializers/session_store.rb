# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_guild_ticketer_session',
  :secret      => '2b2f81bc1929269bb199e5e9fa56067aca5707f2a6fd404e9e52e53dae7d3b805a20ab37b7417469133180866ae8ac1f29e013328e0976c531ae0215cdad456e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

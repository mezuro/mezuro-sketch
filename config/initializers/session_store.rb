# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mezuro_session',
  :secret      => '5a7f49c575caafae727c9ba6c44d99ffcb9c402e62db4521f3c414cf7709303fcb1c4915934099385be60e9e2e358de96103f6ea745cc429c8f473784e8f9470'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

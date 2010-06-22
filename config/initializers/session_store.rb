# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_assman_session',
  :secret      => '8cf9ae4a42abdbf5662d92af774fd0f92f91d08926ce42f5bce119c3fb3d0b727a7fe937b70670f4e9ff0aba0b3fc305657e7ee4d16c905a7fb0479a092d883e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

ActionController::Dispatcher.middleware.insert_before(ActionController::Session::CookieStore,FlashSessionCookieMiddleware,ActionController::Base.session_options[:key])

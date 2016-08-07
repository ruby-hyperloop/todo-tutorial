require 'pusher'
require 'pusher-fake'

# Pusher-Fake grabs its initial values from the Pusher config so
# we need to set them up first.

Pusher.app_id = "MY_TEST_ID"       # If you have a pusher account you can put
Pusher.key =    "MY_TEST_KEY"      # your account values here, but these (or
Pusher.secret = "MY_TEST_SECRET"   # any values) will work fine with pusher-fake

# The next line actually fires up the pusher-fake websocket server, so we only
# want it to execute in development.  During testing (rspec for example) you
# can require 'pusher-fake/support/rspec' in your spec_helper.rb file (see the
# Pusher-Fake gem documentation for details)

require 'pusher-fake/support/base' if Rails.env.development?

Synchromesh.configuration do |config|
  # set the transport to :pusher
  config.transport = :pusher
  # give a channel prefix (so that you can use pusher for other things too)
  config.channel_prefix = "synchromesh"
  # set up the options.  If we are not in test we merge in the Pusher-Fake
  # configuration (i.e. host and ports and stuff.)
  opts = {app_id: Pusher.app_id, key: Pusher.key, secret: Pusher.secret}
  opts.merge!(PusherFake.configuration.web_options) unless Rails.env.production?
  config.opts = opts
end

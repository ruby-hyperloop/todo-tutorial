## Chapter 7 - Turning on synchromesh

In chapter 6 we put our final pieces in place.  Our app runs fine, but if you open your app in two windows you will see that
changes in one browser are not reflected in the other, unless you refresh.

To enable automatic synchronization add a synchromesh initializer to `app/config/initializers` like this:

```ruby
# app/config/initializers/synchromesh.rb
Synchromesh.configuration do |config|
  config.transport = :simple_poller
end
```

Now restart the server, and visit the todo page on two different browsers.  You should see any changes
in one browser reflected in the other.

Currently Synchromesh has two transports:  `:simple_poller`, and `:pusher`.  The simple_poller sets up each browser
to ping the server and fetch any data changes.  Nice and easy for debug, but in real life you will want to use
websockets.

`www.pusher.com` provides a freemium websocket transport service, that you can use to try out websockets, and there is
a gem called `Pusher-Fake` which will use the pusher protocol, but run the websocket service inside your app.  

So using `Pusher-Fake` you can get a feel for how well `Pusher` works without even signing up for a free account.

Setting up `Pusher` and `Pusher-Fake` has the following steps:

1. Add the gems
2. Update `application.js` manifest
3. Update the `synchromesh.rb` initializer

#### Adding the gems

Add `gem 'pusher'` and `gem 'pusher-fake', :groups => [:development, :test]` to your Gemfile.

Don't forget to `bundle install`

#### Update `application.js` manifest

For convenience synchromesh includes a copy of the pusher.com client js file.

In `app/assets/javascripts/application.js` add the line `//= require synchromesh/pusher` immediately *before* the line that reads `Opal.load('components');`

This will pull in the pusher.com client code.  You can also consult the pusher.com website, and follow the instructions there to get a copy of the pusher client if you prefer.

#### Update the `synchromesh` initializer

```ruby
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
```

## Chapter 7 - Turning on synchromesh

In chapter 6 we put our final pieces in place.  Our app runs fine, but if you open your app in two windows you will see that
changes in one browser are not reflected in the other.

To enable this behavior add a synchromesh initializer to `app/config/initializers` like this:

```ruby
# app/config/initializers/synchromesh.rb
Synchromesh.configuration do |config|
  config.transport = :simple_poller
end
```

Now restart the server, and visit the todo page on two different browsers.  You should see any changes
in one browser reflected in the other.

**THE FOLLOWING NEEDS TO BE TESTED TO MAKE SURE ALL SETTINGS ARE CORRECT**
Currently Synchromesh has two transports:  `:simple_poller`, and `:pusher`.  The simple_poller sets up each browser
to ping the server and fetch any data changes.  Nice and easy for debug, but in real life you will want to use
websockets.

`www.pusher.com` provides a freemium websocket transport service, that you can use to try out websockets, and there is
a gem called `Pusher-Fake` which will use the pusher protocol, but run the websocket service inside your app.  To set
that up change the `synchromesh.rb` initializer like this:

```ruby
require 'pusher'
require 'pusher-fake'
Pusher.app_id = "MY_TEST_ID"       # If you have a pusher account you can put
Pusher.key =    "MY_TEST_KEY"      # your account values here, but these (or
Pusher.secret = "MY_TEST_SECRET"   # any values) will work fine with pusher-fake
require 'pusher-fake/support/rspec'

Synchromesh.configuration do |config|
  config.transport = :pusher
  config.channel_prefix = "synchromesh"
  config.opts = {app_id: Pusher.app_id, key: Pusher.key, secret: Pusher.secret}.
                merge(PusherFake.configuration.web_options)
end
```

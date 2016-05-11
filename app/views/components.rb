# app/react/components.rb
require 'opal'
require 'reactive-ruby'
require 'react'
if React::IsomorphicHelpers.on_opal_client?
  require 'opal-jquery'
  require 'browser'
  require 'browser/interval'
  require 'browser/delay'
  # add any additional requires that can ONLY run on client here
end
require 'reactive-router'
require 'react_router'
require 'reactive-record'
require '_react_public_models'
require_tree './components'

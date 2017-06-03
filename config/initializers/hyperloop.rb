# config/initializers/hyperloop.rb        
Hyperloop.configuration do |config|
  config.prerendering = :off if ENV['C9_PROJECT']
  config.transport = :action_cable
  config.compress_system_assets = false # its not worth minimizing assets cause cloud9 is slow
  config.import 'opal_hot_reloader' if Rails.env.development?
end

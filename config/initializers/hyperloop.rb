# config/initializers/hyperloop.rb        
Hyperloop.configuration do |config|
  if ENV['C9_PROJECT']
    # Cloud 9 base workspaces are only 512MB which is too small effectively support these features
    # if you increase your cloud9 workspace to 1GB you can remove this
    config.prerendering = :off
    config.compress_system_assets = false
  end
  config.transport = :action_cable
  config.import 'opal_hot_reloader' if Rails.env.development?
  config.import 'models/application_record' # force application_record to load first
end

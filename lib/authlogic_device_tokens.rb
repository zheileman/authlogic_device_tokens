require 'authlogic_device_tokens/version'
require 'ostruct'

module AuthlogicDeviceTokens
  autoload :ActsAsAuthentic,  'authlogic_device_tokens/acts_as_authentic'
  autoload :Session,          'authlogic_device_tokens/session'
end

require 'authlogic_device_tokens/railtie' if defined?(Rails) && Rails::VERSION::MAJOR >= 3

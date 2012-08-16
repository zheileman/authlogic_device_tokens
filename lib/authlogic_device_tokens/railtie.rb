require 'authlogic_device_tokens'
require 'rails'

module AuthlogicDeviceTokens
  class Railtie < Rails::Railtie
    
    initializer "authlogic_device_tokens.active_record" do |app|
      ActiveSupport.on_load :active_record do

        if respond_to?(:add_acts_as_authentic_module)
          Authlogic::Session::Base.send :include, AuthlogicDeviceTokens::Session
          include AuthlogicDeviceTokens::ActsAsAuthentic
        end

      end
    end
    
  end
end
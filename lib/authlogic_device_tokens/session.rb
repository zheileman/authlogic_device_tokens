module AuthlogicDeviceTokens
  module Session
    autoload :Config, 'authlogic_device_tokens/session/config'
    autoload :Device, 'authlogic_device_tokens/session/device'
       
    def self.included(klass)
      klass.extend Session::Config
      klass.send(:include, Session::Device)
    end
  end
end

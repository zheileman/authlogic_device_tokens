module AuthlogicDeviceTokens
  module Session
    
    module Config
      def self.extended(klass)
        (class << klass; self end).send(:define_method, :default_config) do
          @default_config ||= OpenStruct.new({})
        end
      end
      

      # The name of the key in the cookies hash when authenticating by device
      #
      # * <tt>Default:</tt> :device
      # * <tt>Accepts:</tt> Symbol
      def device_cookie_key(value=nil)
        rw_config(:device_cookie_key, value, :device_credentials)
      end
      alias_method :device_cookie_key=, :device_cookie_key

      # The name of session key when authenticating by device
      #
      # * <tt>Default:</tt> :device
      # * <tt>Accepts:</tt> Symbol
      def device_session_key(value=nil)
        rw_config(:device_session_key, value, :device_session)
      end
      alias_method :device_session_key=, :device_session_key


      # What device field should be used for authentification?
      #
      # * <tt>Default:</tt> :auth_token
      # * <tt>Accepts:</tt> Symbol
      def device_auth_token_field(value=nil)
        rw_config(:device_auth_token_field, value, :auth_token)
      end
      alias_method :device_auth_token_field=, :device_auth_token_field

      # What device field should be used for sockets authentification?
      #
      # * <tt>Default:</tt> :socket_token
      # * <tt>Accepts:</tt> Symbol
      def device_socket_token_field(value=nil)
        rw_config(:device_socket_token_field, value, :socket_token)
      end
      alias_method :device_socket_token_field=, :device_socket_token_field


      # What method should be used to find the Device given a token?
      #
      # * <tt>Default:</tt> :find_by_#{device_auth_token_field}
      # * <tt>Accepts:</tt> Symbol or String
      def device_finder(value=nil)
        rw_config(:device_finder, value, false)
      end
      alias_method :device_finder=, :device_finder
      
      # What method should be used to find the User?
      #
      # * <tt>Default:</tt> :find_by_device_#{device_auth_token_field}
      # * <tt>Accepts:</tt> Symbol or String
      def user_device_finder(value=nil)
        rw_config(:user_device_finder, value, false)
      end
      alias_method :user_device_finder=, :user_device_finder
    end

  end
end
module AuthlogicDeviceTokens
  module Session
    
    module Device
      
      def self.included(klass)
        klass.class_eval do
          attr_accessor :skip_device_authentication
          attr_reader :auth_token
          validate :validate_by_device, :if => :authenticating_with_device?
          
          def self.destroy_if_any type = nil
            find.try(:destroy)
            controller.cookies.delete (type == :device ? device_cookie_key : cookie_key)
          end
        end
      end
      
      def credentials=(value)
        super
        values = value.is_a?(Array) ? value : [value]
        hash = values.first.is_a?(Hash) ? values.first.with_indifferent_access : nil
        self.auth_token = hash[:auth_token] if hash && hash.key?(:auth_token)
      end

      def auth_token=(value)
        @auth_token = value
      end

      def logged_in_with_device?
        !!@logged_in_with_device
      end

      def device_session
        @device_session ||= (self.auth_token ? OpenStruct.new({auth_token: self.auth_token}) : nil)
      end
 
      def device_user
        @device_user ||= OpenStruct.new({auth_token: device_session.try(:auth_token)})
      end
      
      def device
        @device ||= (device_session ? self.record.devices.send(device_finder, device_user.auth_token) : nil)
      end


      protected

      def authenticating_with_device?
        !skip_device_authentication && !authenticating_with_unauthorized_record? && attempted_record.nil? && device_session
      end


      private

      def validate_by_device
        device_token = device_user.auth_token
        self.attempted_record = klass.send(user_device_finder, device_token)
        if self.attempted_record
          @logged_in_with_device = !!self.attempted_record
        end
      end
      
      def persist_by_session
        session_auth_token = controller.session[device_session_key]
        if session_auth_token
          self.auth_token = session_auth_token
          self.unauthorized_record = klass.send(user_device_finder, session_auth_token)
          @logged_in_with_device = valid?
        else
          super
        end
      end
      
      def update_session
        if device_session
          controller.session[device_session_key] = device_user.auth_token
        else
          super
        end
      end
      
      def persist_by_cookie
        cookie_auth_token = controller.cookies[device_cookie_key]
        if cookie_auth_token
          self.auth_token = cookie_auth_token
          self.unauthorized_record = klass.send(user_device_finder, cookie_auth_token)
          @logged_in_with_device = valid?
        else
          super
        end
      end
      
      def save_cookie
        if device_session
          controller.cookies[device_cookie_key] = {
            :value => device_user.auth_token,
            :expires => remember_me_until,
            :secure => secure,
            :httponly => httponly,
            :domain => controller.cookie_domain
          }
        else
          super
        end
      end

      def device_cookie_key
        self.class.device_cookie_key
      end
      def device_session_key
        self.class.device_cookie_key
      end

      def device_auth_token_field
        self.class.device_auth_token_field
      end
      def device_socket_token_field
        self.class.device_socket_token_field
      end

      def device_finder
        self.class.device_finder || "find_by_#{device_auth_token_field}"
      end
      def user_device_finder
        self.class.user_device_finder || "find_by_device_#{device_auth_token_field}"
      end

    end
      
  end
end

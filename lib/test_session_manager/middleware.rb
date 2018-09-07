require 'action_dispatch/middleware/flash'

class TestSessionManager
  class Middleware
    def initialize(app, manager)
      @app = app
      @manager = manager
    end

    def call(env)
      session = env['rack.session']

      if @manager.flash.any?
        flash = flash_from_session(session['flash'])
        flash.update(@manager.flash)
        session['flash'] = flash.to_session_value
      end

      @manager.session.each do |key, value|
        session[key] = value
      end

      @manager.reset!

      @app.call(env)
    end

    def flash_from_session(value)
      if value.is_a?(Hash)
        ActionDispatch::Flash::FlashHash.new(value['flashes'], value['discard'] || [])
      else
        ActionDispatch::Flash::FlashHash.new
      end
    end
  end
end

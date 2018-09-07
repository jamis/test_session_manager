require 'test_session_manager/middleware'

class TestSessionManager
  attr_reader :flash, :session

  def initialize
    reset!
  end

  def reset!
    @flash = {}
    @session = {}
  end
end

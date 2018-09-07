require 'test_helper'

class SessionManagerTest < ActiveSupport::TestCase
  setup do
    @manager = TestSessionManager.new
  end

  test 'test session manager starts with empty hashes' do
    assert @manager.flash.empty?
    assert @manager.session.empty?
  end

  test 'reset! removes all values from hashes' do
    @manager.flash[:a] = "something"
    @manager.session[:b] = "something"

    refute @manager.flash.empty?
    refute @manager.session.empty?

    @manager.reset!

    assert @manager.flash.empty?
    assert @manager.session.empty?
  end
end
